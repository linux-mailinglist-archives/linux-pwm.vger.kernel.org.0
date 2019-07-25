Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD2075AEC
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jul 2019 00:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfGYWw0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Jul 2019 18:52:26 -0400
Received: from vern.gendns.com ([98.142.107.122]:42466 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfGYWw0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 25 Jul 2019 18:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cufzKvM23k36qgeaMJsciSzpLS9HDdtbAMUo1XycXVU=; b=fdgCHBt0SFE0H/5+b0ciMuO96a
        66c4HpMoHFj8BHwLUVPet+9ACY2TfL7cm4KsIR30wPSIJeiogYdSa0HnrRMPmk0gZRDQbyPV/6ojb
        hrXLItSPw4YEX8pHiHZvGuUx+2/Ss3DK7P8i5wTHW7918UmABAcoySt3TtghDe9IDB4+OX8Kq23Ez
        e2loW2naJtnwS9AV1GijkuyuP44yHdlIkYN5haA10DdH4AEXhNDN0Lg0i5KCeWv5S3E6oy6/mTkSG
        d3cCZDR8GjHWS7B7o+LOh4HaYl3e/ShmRquRddApKolQScySmgBs+bENcK7o7Zbaht567WlgfFADb
        p0QkG8XA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:45618 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hqmb0-000Lvg-4H; Thu, 25 Jul 2019 18:52:22 -0400
Subject: Re: [PATCH 0/4] new driver for TI eQEP
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20190722154538.5314-1-david@lechnology.com>
 <20190725124037.GA4802@icarus>
From:   David Lechner <david@lechnology.com>
Message-ID: <4616508c-d753-586d-0d3b-5a003e86f582@lechnology.com>
Date:   Thu, 25 Jul 2019 17:52:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725124037.GA4802@icarus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/25/19 7:40 AM, William Breathitt Gray wrote:
> On Mon, Jul 22, 2019 at 10:45:34AM -0500, David Lechner wrote:
>> This series adds device tree bindings and a new counter driver for the Texas
>> Instruments Enhanced Quadrature Encoder Pulse (eQEP).
>>
>> As mentioned in one of the commit messages, to start with, the driver only
>> supports reading the current counter value and setting the min/max values.
>> Other features can be added on an as-needed basis.
>>
>> The only other feature I am interested in is adding is getting time data in
>> order to calculate the rotational speed of a motor. However, there probably
>> needs to be a higher level discussion of how this can fit into the counter
>> subsystem in general first.
> 
> I believe exposing some sort of time data has merit. Quadrature counter
> devices in particular are commonly used for position tracking of
> automation systems, and such systems would benefit from velocity/speed
> information. So let's try to introduce that sort of functionality in this
> driver if possible.
> 
> First, let's discuss your specific use case and requirements, and hopefully we
> can generalize it enough to be of use for future drivers. From your description,
> it sounds like you're attaching some sort of rotary encoder to the eQEP device.
> Is that correct? What sort of time data are you hoping to use; does the eQEP
> device provide a clock value, or would you be grabbing a timestamp from the
> system?

My use case is robotics using LEGO MINDSTORMS. More specifically, I am using
motors that have a cheap optical rotary encoder (plastic wheel and infrared
LED/detectors) that give 360 counts per 1 rotation of the motor shaft. One count
is defined as the rising edge or falling edge of the A signal. We are looking at
anywhere from 0 to around 2000 counts per second. We use the speed as feedback in
a control algorithm to drive the motor at a constant speed. The control loop
updates on the order of 1 to 10 ms.

Because the encoder resolution and speeds are relatively low, we are currently
logging a timestamp for each count. If no count occurs for 50ms, then we log the
same count again with a new timestamp (otherwise we would never see 0 speed). To
get the actual speed, we find the first timestamp > 20 ms before the current
timestamp then compute the speed as the change in position divided by the change
in time between these two samples. This give a fairly accurate speed across most
of the range, but does get a bit noisy once we get below 100 counts per second.
It also means that we need a ring buffer that holds about 50 samples.

The timestamp itself comes from the eQEP, not the system. There are latching
registers to ensure that the timestamp read is from exactly the moment when
the count register was read.

  
> I'm not sure yet if it would make sense to expose rotational speed directly as
> an attribute. If we were to expose just the count value and timestamp since the
> last read, that should be enough for a user to compute the delta and derive
> speed. I'll think more about this since some devices may simplify that case if
> the hardware is able to compute the speed for us.
> 

I agree that it probably doesn't make sense to expect drivers to compute the
speed. There isn't really a general way to do that works for an arbitrary
speed. For example at high speeds, it is better to just look at the change
in counts over a fixed interval rather than triggering a timestamp based on
a certain number of counts.

I also don't think having a timestamp sysfs attribute would be very useful.
To make it work at all, I think it would have to be implemented such that
it returns the timestamp for the count that was most recently read via sysfs.
And it would require 4 syscalls (2 seeks and 2 reads) to get a single count/
timestamp pair in a control loop. On a 300MHz ARM9 processor, this is not
a negligible amount of time.

I noticed that several of the other counter drivers also register an IIO
device. So this got me thinking that perhaps the counter subsystem should
just be for configuring a counter device an then the IIO subsystem should
be used for triggers and ring buffers.

For the general case a counter device could have two possible triggers.
One that triggers an interrupt after X counts and another that triggers
with a period of T nanoseconds (or microseconds). Both triggers would add
a count/timestamp pair to an IIO ring buffer.

To fully reproduce our current methodology the first trigger would actually
need two configurable settings, the count X that triggers every X counts and
a watchdog time setting (using terminology from eQEP docs) that will also
trigger if and only if the count does not change before the time has elapsed.
Note, this is different from the other proposed time based trigger which
would cause a trigger interrupt at a fixed period regardless of whether
the count changed or not.

---

Thinking more generally though, I think what I would propose is adding a new
component to the existing list of Count, Signal and Synapse. The new component
could be called Event. Event would be more general than the trigger conditions
I have just discussed. In addition to those two, it could be any event
generated by the hardware, such as an error condition or a change in direction.

Drivers could register an arbitrary number of events for each Count, so we
would have /sys/bus/counter/devices/counterX/eventY/*. There should be a few
standard attributes, like "name" and "enable". Configurable events would need
ext attributes to allow configuration.

However, I see that there are already preset and error_noise "events" for
count objects, so maybe we don't do the eventY thing and keep it flatter (or
is the counter subsystem still considered in "staging" where breaking ABI
changes could be made?).

When thinking about what events would actually do when enabled though, it
seems like we should be using IIO events and triggers (we have found reading
sysfs attributes to be insufficient performance-wise). It seems like unnecessary
work to reproduce all of this in the counter subsystem. Which makes me wonder if
it would be better to have counter devices just be a different device type (i.e.
different struct device_type for dev->type) in the IIO subsystem instead of
creating a completely new subsystem.
