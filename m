Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB37A01B
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2019 06:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfG3EqB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jul 2019 00:46:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36477 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfG3EqB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jul 2019 00:46:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so29153970pfl.3;
        Mon, 29 Jul 2019 21:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wv8DWY08GJEMxC7NWmO7+gLC+yTdYVQmPavAno3uIdU=;
        b=PiZOHOhFVESZCZRuk8yA2q62dB4REo9ehIvOOLnyMVpMb878mrDpqxzyO7oSS5iFH8
         2Jvca/DAnruayAq06RMV5jgjjRlzC2LnqIn3B6CtXnn96ntvi4r7JtwyIFTqRUMAE6ru
         rZkMz2XR+5zYDAntaPBp6mC3qCc2O3frrldjw8azwP1yi56gRMlvw1IMdnqbZmc0IsJB
         3HK2Zfos/LG7WXYTZmwnulabRWqSqK/+6nFkUc3OAxw12rPXLaQ+dYZIHLk1p8sbCnnw
         qPG+8YMHjxxoe5EyUakYeoUkDLmpsI+tyg9TjxIBPts2O7k5CUt45slrdfWstMHyJRRk
         5dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wv8DWY08GJEMxC7NWmO7+gLC+yTdYVQmPavAno3uIdU=;
        b=MnuI62kMZFqJ9tNNtTWwEYcHznHElUvoJHk54bx0Rq95LS6gsw8MBNHyh3Y5n67t2w
         fqCSxlyJUp2+zKOqhAEyZIYIC7xM3NjtW8N4hxxLG4svLcgzpKtumIsLtOTOHoL83pQ6
         UckWn2tAIGPa/mFYBxHOlWyP5+H+7Q842Nfa95yu5YUu03DU2URas9I3TDSRlagyur6U
         JmSXMYcWWgWHRah3B3JpJQbB6s5z6CPnZ0mopvGaEsADeAyE5G/F8FVCO0vvI/NIpK5d
         ffgJpY1T7K2uAD/sDPL8o9TdDJKwVC4qaT4kC541RyDxKOqiy8LtUYTJqqmBO0rRtpca
         r9hw==
X-Gm-Message-State: APjAAAWZkUpMfx7AOAI14j2DwvmcNxRGDQ3dnNPVGBQvo1CYNs5JnWUY
        WxmOqTVfHluU3isw0JiVmKQ=
X-Google-Smtp-Source: APXvYqxFCfAzJGa1k5c3LAK/vUqF/r7i1noLfCqemvD+Wd9M3RjfvKecUzgt1pqjSfDPgsHrPKMn+w==
X-Received: by 2002:a62:35c6:: with SMTP id c189mr40033698pfa.96.1564461960067;
        Mon, 29 Jul 2019 21:46:00 -0700 (PDT)
Received: from icarus ([2001:268:c147:5dce:41f:f559:d580:dcd4])
        by smtp.gmail.com with ESMTPSA id c8sm72532828pjq.2.2019.07.29.21.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 21:45:58 -0700 (PDT)
Date:   Tue, 30 Jul 2019 13:45:36 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/4] new driver for TI eQEP
Message-ID: <20190730044536.GA5063@icarus>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190725124037.GA4802@icarus>
 <4616508c-d753-586d-0d3b-5a003e86f582@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4616508c-d753-586d-0d3b-5a003e86f582@lechnology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 25, 2019 at 05:52:21PM -0500, David Lechner wrote:
> On 7/25/19 7:40 AM, William Breathitt Gray wrote:
> > On Mon, Jul 22, 2019 at 10:45:34AM -0500, David Lechner wrote:
> >> This series adds device tree bindings and a new counter driver for the Texas
> >> Instruments Enhanced Quadrature Encoder Pulse (eQEP).
> >>
> >> As mentioned in one of the commit messages, to start with, the driver only
> >> supports reading the current counter value and setting the min/max values.
> >> Other features can be added on an as-needed basis.
> >>
> >> The only other feature I am interested in is adding is getting time data in
> >> order to calculate the rotational speed of a motor. However, there probably
> >> needs to be a higher level discussion of how this can fit into the counter
> >> subsystem in general first.
> > 
> > I believe exposing some sort of time data has merit. Quadrature counter
> > devices in particular are commonly used for position tracking of
> > automation systems, and such systems would benefit from velocity/speed
> > information. So let's try to introduce that sort of functionality in this
> > driver if possible.
> > 
> > First, let's discuss your specific use case and requirements, and hopefully we
> > can generalize it enough to be of use for future drivers. From your description,
> > it sounds like you're attaching some sort of rotary encoder to the eQEP device.
> > Is that correct? What sort of time data are you hoping to use; does the eQEP
> > device provide a clock value, or would you be grabbing a timestamp from the
> > system?
> 
> My use case is robotics using LEGO MINDSTORMS. More specifically, I am using
> motors that have a cheap optical rotary encoder (plastic wheel and infrared
> LED/detectors) that give 360 counts per 1 rotation of the motor shaft. One count
> is defined as the rising edge or falling edge of the A signal. We are looking at
> anywhere from 0 to around 2000 counts per second. We use the speed as feedback in
> a control algorithm to drive the motor at a constant speed. The control loop
> updates on the order of 1 to 10 ms.
> 
> Because the encoder resolution and speeds are relatively low, we are currently
> logging a timestamp for each count. If no count occurs for 50ms, then we log the
> same count again with a new timestamp (otherwise we would never see 0 speed). To
> get the actual speed, we find the first timestamp > 20 ms before the current
> timestamp then compute the speed as the change in position divided by the change
> in time between these two samples. This give a fairly accurate speed across most
> of the range, but does get a bit noisy once we get below 100 counts per second.
> It also means that we need a ring buffer that holds about 50 samples.
> 
> The timestamp itself comes from the eQEP, not the system. There are latching
> registers to ensure that the timestamp read is from exactly the moment when
> the count register was read.

So if I understand correctly, there are two registers you're reading: a
count register and a timestamp register. The count register is updated
by the rotation of the motor shaft, while the timestamp register is
updated by reading the count register (thus logging the time associated
with the read count value).

> > I'm not sure yet if it would make sense to expose rotational speed directly as
> > an attribute. If we were to expose just the count value and timestamp since the
> > last read, that should be enough for a user to compute the delta and derive
> > speed. I'll think more about this since some devices may simplify that case if
> > the hardware is able to compute the speed for us.
> > 
> 
> I agree that it probably doesn't make sense to expect drivers to compute the
> speed. There isn't really a general way to do that works for an arbitrary
> speed. For example at high speeds, it is better to just look at the change
> in counts over a fixed interval rather than triggering a timestamp based on
> a certain number of counts.

This is a good point. Depending on the resolution the user cares about,
they may be more interested in the speed over a short time interval
versus a long time interval. It doesn't seem practical to have the driver
try to handle all possible speed calculations when the user can decide
themselves how best to use the data.

> I also don't think having a timestamp sysfs attribute would be very useful.
> To make it work at all, I think it would have to be implemented such that
> it returns the timestamp for the count that was most recently read via sysfs.
> And it would require 4 syscalls (2 seeks and 2 reads) to get a single count/
> timestamp pair in a control loop. On a 300MHz ARM9 processor, this is not
> a negligible amount of time.

This is a concern I've had as well. The sysfs interface is useful in
that it provides an intuitive and human-friendly way to expose data
about devices. But as you note, there is considerable overhead in the
amount of syscalls we have to make to interact with multiple attributes.

One solution that may work is providing a character device interface in
addition to the sysfs interface. I believe that should reduce the
syscall overhead since a user can pass in a data structure with a
configuration defining what data/actions they want, and receive back
all data in a single syscall.

I think concern over latency was one of the reasons the GPIO subsystem
gained a character device interface as well. It's an addition to the
Counter subsystem that is worth considering, but the possible downsides
to such an interface should also be investigated.
 
> I noticed that several of the other counter drivers also register an IIO
> device. So this got me thinking that perhaps the counter subsystem should
> just be for configuring a counter device an then the IIO subsystem should
> be used for triggers and ring buffers.
> 
> For the general case a counter device could have two possible triggers.
> One that triggers an interrupt after X counts and another that triggers
> with a period of T nanoseconds (or microseconds). Both triggers would add
> a count/timestamp pair to an IIO ring buffer.
> 
> To fully reproduce our current methodology the first trigger would actually
> need two configurable settings, the count X that triggers every X counts and
> a watchdog time setting (using terminology from eQEP docs) that will also
> trigger if and only if the count does not change before the time has elapsed.
> Note, this is different from the other proposed time based trigger which
> would cause a trigger interrupt at a fixed period regardless of whether
> the count changed or not.

The counter drivers in the kernel right now are registering IIO devices
in order to keep the preexisting (but now deprecated) IIO Counter
interface working for these devices -- some users may be using this
older interface so we don't want to remove it cold turkey. Regardless,
there's nothing the prevents incorporating the IIO interface with your
Counter drivers; in fact, in some circumstances it's better that you do
just that.

The key idea to recognize is how the Counter subsystem differs from the
IIO subsystem on a conceptual level: the IIO subsystem provides an
interface for your device by describing it on a hardware level, whereas
the Counter subsystem provides an interface for your device by
describing it on a more abstract level.

What I mean is that every interface interaction in the Counter subsystem
relates to the abstract concept of an ideal "counter device" (Counts,
Synapses, Signals); if a device functionality or data does not relate
directly to those ideal counter device components, then the Counter
subsystem isn't that right interface for it.

For example, it makes sense to have an "enable" attribute or "present"
attribute, because these functionalities/data are directly related to
the Count, Synapse, and Signal components conceptually. However, in the
Counter subsystem you will likely not see something like the IIO
"in_voltageY_supply_raw" attribute -- not because that data is not
useful to know about for the operation of the counter device hardware,
but because it is outside the scope of the Counter subsystem paradigm
(i.e. it does not directly related to Counts, Synapses, or Signals).
As such, this would be a case where the counter driver should register
both a Counter device and IIO device, one to handle the counter device
on an abstract level while the other provides an interface for control
of the more specific hardware details.

> ---
> 
> Thinking more generally though, I think what I would propose is adding a new
> component to the existing list of Count, Signal and Synapse. The new component
> could be called Event. Event would be more general than the trigger conditions
> I have just discussed. In addition to those two, it could be any event
> generated by the hardware, such as an error condition or a change in direction.
> 
> Drivers could register an arbitrary number of events for each Count, so we
> would have /sys/bus/counter/devices/counterX/eventY/*. There should be a few
> standard attributes, like "name" and "enable". Configurable events would need
> ext attributes to allow configuration.
> 
> However, I see that there are already preset and error_noise "events" for
> count objects, so maybe we don't do the eventY thing and keep it flatter (or
> is the counter subsystem still considered in "staging" where breaking ABI
> changes could be made?).

The components for handling events already exist in the Counter
interface paradigm: Signals and Synapses. Although, the Counter
subsystem is currently lacking the implementation (I still need to code
in support for interrupts and such), the paradigm itself supports the
concept of events and triggers.

Recall that the Counter subsystem represents hardware via the
abstraction of an idealized "counter device". This is important to
understand because it means that Signals are not necessarily limited to
the physical wires of the hardware. To summarize the Counter interface
paradigm:

    * A Signal is a stream of data to be evaluated.
    * A Synapse is a trigger condition based on the evaluation of the
      data streams (i.e. the Signals).
    * A Count is the accumulation of the effects of Synapses (i.e. the
      triggers).

As such, in order to represent an event, you would add in a Signal to
represent the stream of device events, and a Synapse defining the
specific event that will trigger the action. I'll give an example in
order to demonstrate what I mean.

A simple clock can be conceptualize as a proper counter device: an
oscillation is a Signal, a rising edge from that oscillation line can be
the Synapse, and the current clock value is the Count.

                Count                Synapse          Signal
                -----                -------          ------
        +---------------------+
        | Data: Clock ticks   |    Rising Edge     _____________
        | Function: Increase  |  <-------------   / Oscillation \
        |                     |                  _________________
        +---------------------+

Now, in order to represent your timestamping clock we need two Signals:
a simple clock and an event stream. The simple clock is the source of
the current clock ticks we will store, while the event stream provides
the rotation count register read notification that will trigger the
timestamp.

                   Count                       Synapse      Signal
                   -----                       -------      ------
        +-------------------------------+
        | Data: Timestamp               |       None        _______
        | Function: Current clock ticks |  <------------   / Clock \
        |                               |                 ___________
        |                               |
        |                               |    Read event     ________
        |                               |  <------------   / Events \
        |                               |                 ____________
        +-------------------------------+

Note that in this case both Signals either do not exist in or are not
exposed by the hardware (maybe the simple clock is exposed, but it's not
necessary to be) -- they are meant to be abstract representations of the
components of the timestamp clock as an idealized "counter device".

By organizing the timestamp clock in this way, we can control and
configure the components using the standard Counter interface: common
attributes such as "name", "preset", "enable", etc. can now be exposed
to users like every other counter device component.

In theory we can sleep on the timestamp count attribute read (or
character device equivalent if we go down that route), and be woken when
an event triggers updating the timestamp value. However, the current
Counter subsystem implementation is lacking the code for this so it
needs to be added to the core functionality first.

> When thinking about what events would actually do when enabled though, it
> seems like we should be using IIO events and triggers (we have found reading
> sysfs attributes to be insufficient performance-wise). It seems like unnecessary
> work to reproduce all of this in the counter subsystem. Which makes me wonder if
> it would be better to have counter devices just be a different device type (i.e.
> different struct device_type for dev->type) in the IIO subsystem instead of
> creating a completely new subsystem.

I plan on adding interrupt support for the 104-QUAD-8 counter driver
since this device has some useful interrupts on configured threshold
conditions and such, so having the ability to handle an event rather
than constantly read and loop is something I want to have in the Counter
subsystem.

It's possible that I can reuse some code from the IIO subsystem, as
Jonathan pointed out, but overall I believe these should be separate
subsystems. From the reasons described above, the IIO subsystem and
Counter subsystem have different goals and thus different
implementations. I don't think that's a bad thing, and we can share code
in the few cases where the two may overlap.

Regarding whether to use IIO events and triggers within the TI eQEP
counter driver, I think we should wait for a proper Counter subsystem
implementation to be added first. My fear is that we'll have a similar
situation as what happened with IIO_COUNT, where we'll have to keep a
IIO interface present with a newer Counter interface. If adding in event
support to the Counter subsystem will take too long, we can add this TI
eQEP driver as-is now and later add in the timestamp support.

William Breathitt Gray
