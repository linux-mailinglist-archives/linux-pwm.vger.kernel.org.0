Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A32361F98
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Apr 2021 14:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhDPMQJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Apr 2021 08:16:09 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:40234 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhDPMQJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Apr 2021 08:16:09 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 13GCFQJd029781; Fri, 16 Apr 2021 21:15:26 +0900
X-Iguazu-Qid: 34trSOSPthsRJckbCs
X-Iguazu-QSIG: v=2; s=0; t=1618575326; q=34trSOSPthsRJckbCs; m=7HPJQplQYDVdOr5qiRc8LTUir5zBahKRvEqdYSEGzxQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1512) id 13GCFPEU030896
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 21:15:25 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 0C1031000DC;
        Fri, 16 Apr 2021 21:15:25 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 13GCFOLS011662;
        Fri, 16 Apr 2021 21:15:24 +0900
Date:   Fri, 16 Apr 2021 21:15:23 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
X-TSB-HOP: ON
Message-ID: <20210416121523.c34trzsrlcjuzirl@toshiba.co.jp>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210410135321.oissremqropvrpd3@pengutronix.de>
 <20210412025536.i5chpp6sighunvfx@toshiba.co.jp>
 <20210412070232.6q3cgqvuj53p4cmi@pengutronix.de>
 <20210416080721.oa7xdvu22w2b2rkf@toshiba.co.jp>
 <20210416094426.x4gyw3drp2fcwczs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416094426.x4gyw3drp2fcwczs@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for your comment.

On Fri, Apr 16, 2021 at 11:44:26AM +0200, Uwe Kleine-König wrote:
> Hello Nobuhiro,
> 
> On Fri, Apr 16, 2021 at 05:07:21PM +0900, Nobuhiro Iwamatsu wrote:
> > On Mon, Apr 12, 2021 at 09:02:32AM +0200, Uwe Kleine-König wrote:
> > > On Mon, Apr 12, 2021 at 11:55:36AM +0900, Nobuhiro Iwamatsu wrote:
> > > > On Sat, Apr 10, 2021 at 03:53:21PM +0200, Uwe Kleine-König wrote:
> > > > > Can you please put a paragraph analogous to the one in pwm-sifive in the
> > > > > same format. This simplified keeping an overview about the oddities of
> > > > > the various supported chips.
> > > > 
> > > > OK, I will check pwm-sifive's, and add.
> > 
> > I will add the following :
> > 
> >  * Limitations:
> >  * - PIPGM_PWMC is a 2-bit divider (00: 1, 01: 2, 10: 4, 11: 8) for the input
> >  *   clock running at 1 MHz.
> 
> I would strip that to:
> 
>  - Fixed input clock running at 1 MHz
> 

OK, I will update.

> >  * - When the settings of the PWM are modified, the new values are shadowed
> >  *   in hardware until the PIPGM_PCSR register is written and the currently
> >  *   running period is completed. This way the hardware switches atomically
> >  *   from the old setting to the new.
> >  * - Disabling the hardware completes the currently running period and keeps
> >  *   the output at low level at all times.
> 
> This looks fine.
>  
> > > For me the critical (and only) difference between "off" and
> > > "duty cycle = 0" is that when a new configuration is to be applied. In
> > > the "off" state a new period can (and should) start immediately, while
> > > with "duty_cycle = 0" the rising edge should be delayed until the
> > > currently running period is over.[1]
> > > 
> > > So the thing to do here (IMHO) is:
> > > 
> > > Iff with PIPGM_PCSR = 0 configuring a new setting (that is finalized
> > > with writing a non-zero value to PIPGM_PCSR) completes the currently
> > > running period, then always assume the PWM as enabled.
> > 
> > Yes, this device works that way.
> 
> OK, then please use
> 
> 	state->enabled = true
> 
> unconditionally in visconti_pwm_get_state().
> 

Please let me check.
If I unconditionally add 'state->enabled = true' to visconti_pwm_get_state(),
state->enabled is set to true because visconti_pwm_get_state() is called when
the device is created (this is when I write the device number to the export of
/sys/class/pwm/pwmchip0 ).
And since PIPGM_PCSR is 0 in this state, the pulse by PWM is not output.
However, I think this means that the device is working as this driver.
Is this correct?

> Best regards
> Uwe
> 

Best regards,
  Nobuhiro
