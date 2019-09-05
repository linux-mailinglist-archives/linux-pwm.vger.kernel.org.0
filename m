Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8EAA4A8
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2019 15:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfIENho (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Sep 2019 09:37:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47014 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfIENhn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Sep 2019 09:37:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so1754156pfg.13;
        Thu, 05 Sep 2019 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fi++776ImZEZT48n1qE4d0SlhAt4GD7N11zpq7SBZhM=;
        b=iZ32udt5Ao+f4A8AcqWMD0UzwlSrvD4qFci1gCSpLs167HXqVYUYi0+M1A9Is/tjrD
         dSLyGCd0tUG5IE29UZfmw1UIVLGaf3DaSHlaScDW+EX8J6bW6VlfZHdTVtslVlwEPW55
         AbBtVYL4O7SmjSiyKhKSQ/6e4c3GcOgOm7iYlNwysHhdZs+JeO3YnSH//pWzjkFYoq+Y
         Wo927FE786DNSu9sHlPoCEaLHphRMla1OzN01QiESJNg9tnViF3DHGe20a0yKaRE9NuT
         EthsXjvgs5JZK1C99hc4SjQtyBoLqXW1eItvh+J+VIWJxI3QYY9qjmdBMPcXdh1XDjuD
         gd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fi++776ImZEZT48n1qE4d0SlhAt4GD7N11zpq7SBZhM=;
        b=qxNgG7sY8E4672rhqwam/wjRA9bmeYp0SqKI8i4TLq7Zu4TNilK0yQfkcCYTIE17KA
         O7hJ8wppVlI2au+UX+lSSAcgL2intL7ap/PXa5N87Tclb7Ev/c/7Qe751MRkRW+gTEvH
         6dlkFlnrEH1EuEs6LCFwZXTsdQgrDxPTF/l4cyZoD61W4252fP74OvNjG2tRjevd6C/m
         EFPD/tWhMV1r7AfgtGEajKAbM5z39xlsi/M9CrocaOBnDKrM+3C7qcaKzBIPAGQZwFcG
         HJslk+sltcqe4GT2KoSX+RJC6qUBuMCDs9eyYFbu5nAOHUdx6oVl+x+fcECrcgIcm10c
         OeLg==
X-Gm-Message-State: APjAAAUl6Soyq3HG7wh5e3VOxciTxulW2QoquCEn78jwv/65xMWyYSsP
        kxh5DR7DRgzCzAU2yh9XVP0=
X-Google-Smtp-Source: APXvYqwfariauCzmmaTcCfPD/BTxjV8KxWhNia0IPgs/fMJkiUKEcxPoLnijDvxLMAc8xd3e4YgaWg==
X-Received: by 2002:a17:90a:32c8:: with SMTP id l66mr3979785pjb.44.1567690662640;
        Thu, 05 Sep 2019 06:37:42 -0700 (PDT)
Received: from icarus ([2001:268:c145:7cce:aed2:6823:62ef:c22d])
        by smtp.gmail.com with ESMTPSA id f188sm2268221pfa.170.2019.09.05.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:37:41 -0700 (PDT)
Date:   Thu, 5 Sep 2019 22:37:21 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 0/6] counter: new TI eQEP driver
Message-ID: <20190905133721.GA728346@icarus>
References: <20190901225827.12301-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190901225827.12301-1-david@lechnology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Sep 01, 2019 at 05:58:21PM -0500, David Lechner wrote:
> This series adds device tree bindings and a new counter driver for the Texas
> Instruments Enhanced Quadrature Encoder Pulse (eQEP).
> 
> As mentioned in one of the commit messages, to start with, the driver only
> supports reading the current counter value and setting the min/max values.
> Other features can be added as the counter subsystem gains support for them.
> 
> v3 changes:
> - Minor changes to device tree bindings (style and generic node name)
> - Drop action in initializer
> - Fix ordering of pm runtime disable
> v2 changes:
> - New patch to move TI PWMSS driver from drivers/pwm/ to drivers/bus/
> - Device tree bindings converted to .yaml format
> - Device tree clock renamed from "fck" to "sysclkout"
> - Dropped unused index and strobe signals from counter driver
> - Added synapses and actions to counter driver
> - Fixed base in of kstrtouint()
> - Clarifications in commit messages
> 
> This series has been tested on a BeagleBone Blue with the following script:
> 
> #!/usr/bin/env python3
> 
> from os import path
> from time import sleep
> 
> COUNTER_PATH = '/sys/bus/counter/devices'
> COUNTERS = ['counter0', 'counter1', 'counter2']
> COUNT0 = 'count0'
> COUNT = 'count'
> FUNCTION = 'function'
> CEILING = 'ceiling'
> FLOOR = 'floor'
> ENABLE = 'enable'
> 
> cnts = []
> 
> for c in COUNTERS:
>     function_path = path.join(COUNTER_PATH, c, COUNT0, FUNCTION)
>     with open(function_path, 'w') as f:
>         f.write('quadrature x4')
>     floor_path = path.join(COUNTER_PATH, c, COUNT0, FLOOR)
>     with open(floor_path, 'w') as f:
>         f.write(str(0))
>     ceiling_path = path.join(COUNTER_PATH, c, COUNT0, CEILING)
>     with open(ceiling_path, 'w') as f:
>         f.write(str(0xffffffff))
>     enable_path = path.join(COUNTER_PATH, c, COUNT0, ENABLE)
>     with open(enable_path, 'w') as f:
>         f.write('1')
> 
>     cnt_path = path.join(COUNTER_PATH, c, COUNT0, COUNT)
>     cnts.append(open(cnt_path, 'r'))
> 
> while True:
>     for c in cnts:
>         c.seek(0)
>         val = int(c.read())
>         if val >= 0x80000000:
>             val -= 0x100000000
>         print(val, end=' ')
>     print()
>     sleep(1)
> 
> David Lechner (6):
>   bus/ti-pwmss: move TI PWMSS driver from PWM to bus subsystem
>   dt-bindings: counter: new bindings for TI eQEP
>   counter: new TI eQEP driver
>   ARM: dts: am33xx: Add nodes for eQEP
>   ARM: dts: am335x-boneblue: Enable eQEP
>   ARM: dts: am335x-boneblue: Use of am335x-osd335x-common.dtsi
> 
>  .../devicetree/bindings/counter/ti-eqep.yaml  |  50 ++
>  MAINTAINERS                                   |   6 +
>  arch/arm/boot/dts/am335x-boneblue.dts         | 146 +++---
>  arch/arm/boot/dts/am33xx-l4.dtsi              |  27 +
>  drivers/bus/Kconfig                           |   9 +
>  drivers/bus/Makefile                          |   1 +
>  drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} |   0
>  drivers/counter/Kconfig                       |  11 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/ti-eqep.c                     | 473 ++++++++++++++++++
>  drivers/pwm/Kconfig                           |   9 -
>  drivers/pwm/Makefile                          |   1 -
>  12 files changed, 634 insertions(+), 100 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml
>  rename drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} (100%)
>  create mode 100644 drivers/counter/ti-eqep.c
> 
> -- 
> 2.17.1

I'm satisfied with this version of the patchset.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Jonathan, if you have no objections please pick up this up so that it
can make it to the 5.4 merge window coming in soon. Alternatively, I can
merge it into my repository instead and hold it for a while longer
there, if you prefer that route.

Thank you,

William Breathitt Gray
