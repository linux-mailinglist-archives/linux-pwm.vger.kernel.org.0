Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C964526B7A7
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Sep 2020 02:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgIPA0t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Sep 2020 20:26:49 -0400
Received: from smtp1.axis.com ([195.60.68.17]:43375 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgIOOIA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Sep 2020 10:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=6341; q=dns/txt; s=axis-central1;
  t=1600178879; x=1631714879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+2FD+efoFqVTJlkUJ5XMjiIMqU8nTk9kcX/8TGgG0LM=;
  b=T3AfEqBzKoqo/6hgPo08RsK6t3IF8YzpWmVT2V7/K0twTTeEQQt+gxg6
   YpCz4QoFqfJK3jbnIV+V6RT2lY0aQ5kemARqv+95U1bzl7/htHeq5bmrO
   gnGHApLCYTcik3fyMcgT+gjbV7L3xqNdhy2WYVhmSe2Wn7j5hON+rKDwd
   7JBd0+39M6VfKXBidpCBfvPSIPzSGVo2VHscW9+ooxXQJRYhhKs1AdXSv
   dZGpvZmAJb+U7oyd1bxXRTJdXXukMjD5uHuphbRPLggewFligaWPN/WNe
   4UN8GE3ipiwKeCYNbyFnG3w68R2FdkpzmEWZx8+HdX08WJ0eR2D7lEJDM
   Q==;
IronPort-SDR: W/Pl7TYpr3P8gKIA0khikeW2lf+fo1tKZUmi4r+iAbcG4Wm5WXOrhCly9xOvbo93qmZf07Vw/p
 FII0ViQhn3jvcKHAanwCiK/GUlDwnordj2IUN/inpGyCbaR5JU+xFNLpmCY9S+FxzREv3gDJ96
 sK1e91Tisy20EVFrN1yphQmYR5Y3voLYQKL27ygVYPryel+vLmE9Eld4B8+W8KUe/Or66v3eUB
 EIitKSTgGbU4/JvAd/NJlvXD7ixsNsghgj669yMm0p3w1p1g2KRL7E/s1FX0KT4ulccEgiJ0YG
 IqA=
X-IronPort-AV: E=Sophos;i="5.76,430,1592863200"; 
   d="scan'208";a="12966425"
Date:   Tue, 15 Sep 2020 15:54:45 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <kernel@axis.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <oliver@schinagl.nl>
Subject: Re: [PATCH v2 0/2] GPIO PWM driver
Message-ID: <20200915135445.al75xmjxudj2rgcp@axis.com>
References: <20200902121236.20514-1-vincent.whitchurch@axis.com>
 <20200905164249.5vy23gizpwstbs5c@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905164249.5vy23gizpwstbs5c@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Sep 05, 2020 at 06:42:49PM +0200, Uwe Kleine-König wrote:
> On Wed, Sep 02, 2020 at 02:12:34PM +0200, Vincent Whitchurch wrote:
> > v2:
> >  - [..]
> >  - Stop PWM before unregister
> 
> I didn't take the time yet to look at v2, but just spotted this which is
> wrong. .remove() is not supposed to modify the output. (If the PWM is
> still running in .remove() this is either because it was running at
> bootup and was never modified or is a bug in the consumer code.)

If the PWM is not stopped while unregistering, the hrtimer will still
be active and unloading the module will result in a crash when the next
callback hits.  The consumer can be userspace via sysfs.

# insmod /pwm-gpio.ko
# lsmod
Module                  Size  Used by    Not tainted
pwm_gpio               16384  0
# cd /sys/class/pwm/
# ls
pwmchip0
# cd pwmchip0/
# ls
device     export     npwm       power      subsystem  uevent     unexport
# echo 0 > export
# ls
device     npwm       pwm0       uevent
export     power      subsystem  unexport
# cd pwm0/
# ls
capture     enable      polarity    uevent
duty_cycle  period      power
# echo 100000 > period
# echo 10000 > duty_cycle
# echo 1 > enable
# lsmod
Module                  Size  Used by    Not tainted
pwm_gpio               16384  1
# echo 0 > unexport
# lsmod
Module                  Size  Used by    Not tainted
pwm_gpio               16384  0
# rmmod pwm_gpio
# [   79.609675][    C0] 8<--- cut here ---
[   79.610551][    C0] Unable to handle kernel paging request at virtual address 7f0000ac
[   79.611933][    C0] pgd = (ptrval)
[   79.612588][    C0] [7f0000ac] *pgd=683df811, *pte=00000000, *ppte=00000000
[   79.615083][    C0] Internal error: Oops: 80000007 [#1] SMP ARM
[   79.616194][    C0] Modules linked in: [last unloaded: pwm_gpio]
[   79.617605][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0+ #118
[   79.618535][    C0] Hardware name: ARM-Versatile Express
[   79.620086][    C0] PC is at 0x7f0000ac
[   79.621402][    C0] LR is at __hrtimer_run_queues+0x104/0x5ec
[   79.622143][    C0] pc : [<7f0000ac>]    lr : [<801b75a8>]    psr: 600e0193
[   79.622908][    C0] sp : 80d01da0  ip : 88069868  fp : 7f0000ac
[   79.623612][    C0] r10: 80d88c1d  r9 : 80d00000  r8 : be79e000
[   79.624271][    C0] r7 : be79e000  r6 : 80d08cac  r5 : be79e058  r4 : 88069868
[   79.625044][    C0] r3 : 00000000  r2 : 80d0bb80  r1 : 00000001  r0 : 88069868
[   79.625954][    C0] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   79.626319][    C0] Control: 10c5387d  Table: 68344059  DAC: 00000051
[   79.626470][    C0] Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
[   79.626632][    C0] Stack: (0x80d01da0 to 0x80d02000)
[   79.626884][    C0] 1da0: 80d89ff8 80d89fe4 80d89fd0 00000000 80d092ec 00000000 882c2208 00000012
[   79.627175][    C0] 1dc0: 80adab04 80d08c88 882c2208 00000012 be79e110 12f46c55 801b834c be79e000
[   79.627443][    C0] 1de0: 800e0193 882c2208 00000012 be79e150 be79e110 80d89a80 80d01f68 801b83dc
[   79.627712][    C0] 1e00: 800e0193 0000000f 80d89d78 80c4f780 3db4e000 80d05d40 801c863c be02da00
[   79.627974][    C0] 1e20: 00000000 801b65b4 00000000 ffffe000 80d05d40 801b6608 00989680 00000000
[   79.628235][    C0] 1e40: 80d05d40 801c8360 00000001 00000000 801c863c 801543bc 00000000 ffffffff
[   79.628563][    C0] 1e60: 7fffffff be7a7800 00000011 801c863c 80d08c88 be031480 80d89a94 00000001
[   79.628843][    C0] 1e80: be031480 80d89a94 00000011 be02da00 80d08cac 80110e58 80d88bf4 80196ebc
[   79.629117][    C0] 1ea0: 00000001 80d09314 88129720 80c54f38 00000000 00000000 00000001 be018400
[   79.629393][    C0] 1ec0: c0803100 00000000 80d01f68 8019068c 80c54f38 80190cbc 80d4f7d4 80d09314
[   79.629661][    C0] 1ee0: c080210c 80d01f10 c0802100 80523270 801090e8 600e0013 ffffffff 80d01f44
[   79.629923][    C0] 1f00: 00000001 80d00000 00000000 80100af0 ffffffff 00000001 3db4e000 00012ef9
[   79.630184][    C0] 1f20: 00000000 80d00000 80d08cac 80d08ce8 00000001 80c553d0 00000000 80d01f68
[   79.630456][    C0] 1f40: 3db4e000 80d01f60 801090e4 801090e8 600e0013 ffffffff 00000051 00000000
[   79.630723][    C0] 1f60: 00000000 8015e28c 80d01f7c 808b85b4 80d08c88 80d89410 80d01f8c 12f46c55
[   79.630985][    C0] 1f80: 80d88b34 000000d6 80d08c88 80d08c80 80d9d040 80c3ba58 00000027 80c3ba58
[   79.631257][    C0] 1fa0: befffe00 8015e754 00000001 80c00e6c ffffffff ffffffff 00000000 80c0059c
[   79.631525][    C0] 1fc0: 00000000 80c3ba58 12f16455 00000000 00000000 80c00330 00000051 10c0387d
[   79.631790][    C0] 1fe0: 000008e0 687c9000 410fc090 10c5387d 00000000 00000000 00000000 00000000
[   79.632114][    C0] [<801b75a8>] (__hrtimer_run_queues) from [<801b83dc>] (hrtimer_run_queues+0xb8/0xcc)
[   79.632342][    C0] [<801b83dc>] (hrtimer_run_queues) from [<801b65b4>] (run_local_timers+0x14/0x40)
[   79.632540][    C0] [<801b65b4>] (run_local_timers) from [<801b6608>] (update_process_times+0x28/0x88)
[   79.632739][    C0] [<801b6608>] (update_process_times) from [<801c8360>] (tick_periodic+0x40/0x184)
[   79.632938][    C0] [<801c8360>] (tick_periodic) from [<801c863c>] (tick_handle_periodic+0x28/0x88)
[   79.633140][    C0] [<801c863c>] (tick_handle_periodic) from [<80110e58>] (twd_handler+0x30/0x38)
[   79.633342][    C0] [<80110e58>] (twd_handler) from [<80196ebc>] (handle_percpu_devid_irq+0xd8/0x3ec)
[   79.633549][    C0] [<80196ebc>] (handle_percpu_devid_irq) from [<8019068c>] (generic_handle_irq+0x34/0x44)
[   79.633760][    C0] [<8019068c>] (generic_handle_irq) from [<80190cbc>] (__handle_domain_irq+0x5c/0xb4)
[   79.633965][    C0] [<80190cbc>] (__handle_domain_irq) from [<80523270>] (gic_handle_irq+0x4c/0x90)
[   79.634157][    C0] [<80523270>] (gic_handle_irq) from [<80100af0>] (__irq_svc+0x70/0x98)
[   79.634342][    C0] Exception stack(0x80d01f10 to 0x80d01f58)
[   79.634519][    C0] 1f00:                                     ffffffff 00000001 3db4e000 00012ef9
[   79.634781][    C0] 1f20: 00000000 80d00000 80d08cac 80d08ce8 00000001 80c553d0 00000000 80d01f68
[   79.635016][    C0] 1f40: 3db4e000 80d01f60 801090e4 801090e8 600e0013 ffffffff
[   79.635190][    C0] [<80100af0>] (__irq_svc) from [<801090e8>] (arch_cpu_idle+0x24/0x3c)
[   79.635368][    C0] [<801090e8>] (arch_cpu_idle) from [<8015e28c>] (do_idle+0x190/0x26c)
[   79.635534][    C0] [<8015e28c>] (do_idle) from [<8015e754>] (cpu_startup_entry+0x18/0x1c)
[   79.635699][    C0] [<8015e754>] (cpu_startup_entry) from [<80c00e6c>] (start_kernel+0x504/0x53c)
[   79.635978][    C0] Code: bad PC value
[   79.636268][    C0] ---[ end trace 3c6c5034e210d496 ]---
[   79.636496][    C0] Kernel panic - not syncing: Fatal exception in interrupt
[   79.636912][    C0] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---


