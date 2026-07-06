#!/usr/bin/env python3
"""Presence Detection Demo"""

import asyncio
import random
from datetime import datetime

class PresenceDetector:
    def __init__(self):
        self.room_occupancy = {}
        self.detection_threshold = 0.7
    
    async def detect(self, room_id: str) -> dict:
        """Simulate presence detection"""
        # Simulated detection
        occupancy = random.randint(0, 5)
        confidence = random.uniform(0.6, 1.0) if occupancy > 0 else random.uniform(0.0, 0.4)
        
        return {
            "room_id": room_id,
            "occupancy_count": occupancy,
            "confidence": confidence,
            "timestamp": datetime.now().isoformat(),
            "detection_method": "WiFi CSI"
        }
    
    async def monitor_room(self, room_id: str, duration_seconds: int = 60):
        """Monitor room for presence changes"""
        print(f"\n🛰️  Monitoring room '{room_id}' for {duration_seconds}s...\n")
        
        end_time = datetime.now().timestamp() + duration_seconds
        
        while datetime.now().timestamp() < end_time:
            result = await self.detect(room_id)
            
            status = "🟢 Occupied" if result["occupancy_count"] > 0 else "🔴 Empty"
            confidence = f"{result['confidence']:.1%}"
            
            print(f"[{result['timestamp']}] {status} | Count: {result['occupancy_count']} | Confidence: {confidence}")
            
            await asyncio.sleep(5)  # Check every 5 seconds

async def main():
    detector = PresenceDetector()
    
    print("\n" + "="*60)
    print("   🏠 WiFi Presence Detection Demo")
    print("="*60)
    
    # Monitor multiple rooms
    rooms = ["living-room", "kitchen", "bedroom"]
    
    print(f"\n📍 Monitoring {len(rooms)} rooms...\n")
    
    tasks = []
    for room in rooms:
        tasks.append(detector.monitor_room(room, duration_seconds=30))
    
    await asyncio.gather(*tasks)
    
    print("\n" + "="*60)
    print("   ✅ Demo Complete")
    print("="*60 + "\n")

if __name__ == "__main__":
    asyncio.run(main())
