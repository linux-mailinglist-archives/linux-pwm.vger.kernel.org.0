Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE573634BB
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Apr 2021 13:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhDRLIX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Apr 2021 07:08:23 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:58788 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhDRLIV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Apr 2021 07:08:21 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 13IB7LAG008523; Sun, 18 Apr 2021 20:07:22 +0900
X-Iguazu-Qid: 2wHHhVLfD3Y5mc3bes
X-Iguazu-QSIG: v=2; s=0; t=1618744041; q=2wHHhVLfD3Y5mc3bes; m=f4EreB5GRMyV2IrbzmhIs4qW2c5qsOFBc0nTtuWq2Lk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1112) id 13IB7KHX004202
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 18 Apr 2021 20:07:20 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 3B0971000A8;
        Sun, 18 Apr 2021 20:07:20 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 13IB7JlO007932;
        Sun, 18 Apr 2021 20:07:19 +0900
Date:   Sun, 18 Apr 2021 20:07:18 +0900
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
Message-ID: <20210418110718.4zrh665anbz3wmqc@toshiba.co.jp>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210410135321.oissremqropvrpd3@pengutronix.de>
 <20210412025536.i5chpp6sighunvfx@toshiba.co.jp>
 <20210412070232.6q3cgqvuj53p4cmi@pengutronix.de>
 <20210416080721.oa7xdvu22w2b2rkf@toshiba.co.jp>
 <20210416094426.x4gyw3drp2fcwczs@pengutronix.de>
 <20210416121523.c34trzsrlcjuzirl@toshiba.co.jp>
 <20210417155009.vnqxx3fn2yjzp3qc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210417155009.vnqxx3fn2yjzp3qc@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Sat, Apr 17, 2021 at 05:50:09PM +0200, Uwe Kleine-K�nig wrote:
> Hello Nobuhiro,
> 
> On Fri, Apr 16, 2021 at 09:15:23PM +0900, Nobuhiro Iwamatsu wrote:
> > > > > For me the critical (and only) difference between "off" and
> > > > > "duty cycle = 0" is that when a new configuration is to be applied. In
> > > > > the "off" state a new period can (and should) start immediately, while
> > > > > with "duty_cycle = 0" the rising edge should be delayed until the
> > > > > currently running period is over.[1]
> > > > > 
> > > > > So the thing to do here (IMHO) is:
> > > > > 
> > > > > Iff with PIPGM_PCSR = 0 configuring a new setting (that is finalized
> > > > > with writing a non-zero value to PIPGM_PCSR) completes the currently
> > > > > running period, then always assume the PWM as enabled.
> > > > 
> > > > Yes, this device works that way.
> > > 
> > > OK, then please use
> > > 
> > > 	state->enabled = true
> > > 
> > > unconditionally in visconti_pwm_get_state().
> > 
> > Please let me check.
> > If I unconditionally add 'state->enabled = true' to visconti_pwm_get_state(),
> > state->enabled is set to true because visconti_pwm_get_state() is called when
> > the device is created (this is when I write the device number to the export of
> > /sys/class/pwm/pwmchip0 ).
> > And since PIPGM_PCSR is 0 in this state, the pulse by PWM is not output.
> 
> A PWM that is currently configured with .enabled = true and .duty_cycle
> = 0 doesn't have a pulse, so this is fine.
> 

I understood, thanks.

> > However, I think this means that the device is working as this driver.
> 
> I don't understand this sentence.

The description of the struct pwm_state says "PWM enabled status".
I thought 'state-> enabled' would hold the working state of the hardware.

> 
> Best regards
> Uwe

Best regards,
  Nobuhiro
