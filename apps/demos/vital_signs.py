#!/usr/bin/env python3
"""Vital Signs Demo - Breathing & Heart Rate"""

import asyncio
import random
import math
from datetime import datetime

class VitalSignsMonitor:
    def __init__(self):
        self.breathing_rate = 15  # BPM baseline
        self.heart_rate = 70      # BPM baseline
    
    def simulate_breathing(self, time_step: float) -> float:
        """Simulate breathing rate variation"""
        # Sinusoidal breathing pattern with noise
        base = 15 + 5 * math.sin(time_step / 10)
        noise = random.gauss(0, 0.5)
        return max(10, min(30, base + noise))  # 10-30 BPM range
    
    def simulate_heart_rate(self, time_step: float) -> float:
        """Simulate heart rate variation"""
        # Activity-based variation
        activity = 5 * math.sin(time_step / 20)
        base = 70 + activity
        noise = random.gauss(0, 1)
        return max(50, min(120, base + noise))  # 50-120 BPM range
    
    async def monitor(self, duration_seconds: int = 60):
        """Monitor vital signs"""
        print("\n" + "="*70)
        print("   💓 WiFi-Based Vital Signs Monitoring Demo")
        print("="*70)
        print("\n📊 Real-time breathing and heart rate detection (contactless)\n")
        
        end_time = datetime.now().timestamp() + duration_seconds
        time_step = 0
        
        while datetime.now().timestamp() < end_time:
            breathing = self.simulate_breathing(time_step)
            heart_rate = self.simulate_heart_rate(time_step)
            confidence = random.uniform(0.75, 0.99)
            
            # Visual representation
            breathing_bar = "█" * int(breathing / 2) + "░" * (15 - int(breathing / 2))
            heart_bar = "█" * int(heart_rate / 8) + "░" * (15 - int(heart_rate / 8))
            
            print(f"[{datetime.now().strftime('%H:%M:%S')}]")
            print(f"  🫁 Breathing: {breathing:5.1f} BPM {breathing_bar} {confidence:.0%} confidence")
            print(f"  💓 Heart Rate: {heart_rate:5.1f} BPM {heart_bar} {confidence:.0%} confidence")
            print()
            
            time_step += 1
            await asyncio.sleep(2)  # Update every 2 seconds
        
        print("\n" + "="*70)
        print("   ✅ Monitoring Complete")
        print("="*70 + "\n")

async def main():
    monitor = VitalSignsMonitor()
    await monitor.monitor(duration_seconds=30)

if __name__ == "__main__":
    asyncio.run(main())
