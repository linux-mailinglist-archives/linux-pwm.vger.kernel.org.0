Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2ED35B848
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 03:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhDLBt5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 21:49:57 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:35942 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbhDLBt4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 21:49:56 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 13C1nDka031963; Mon, 12 Apr 2021 10:49:13 +0900
X-Iguazu-Qid: 2wHHmufQV2YIV0Vxxe
X-Iguazu-QSIG: v=2; s=0; t=1618192152; q=2wHHmufQV2YIV0Vxxe; m=CyKWjpYjfiysteLqP0ka033bop3tkwAt3Qm0M4aNgoY=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1112) id 13C1nBLh020460
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 10:49:11 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id A90921000B3;
        Mon, 12 Apr 2021 10:49:11 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 13C1nAJe003560;
        Mon, 12 Apr 2021 10:49:11 +0900
Date:   Mon, 12 Apr 2021 10:49:10 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
X-TSB-HOP: ON
Message-ID: <20210412014910.b5zo3dgpyiwmprot@toshiba.co.jp>
References: <20210409090709.1918021-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409090709.1918021-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <YHBUjPjEpLYF/915@orome.fritz.box>
 <20210409213455.6f25m4jyttqn75hf@toshiba.co.jp>
 <20210410135658.pf7eg5x5bdhndxkg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210410135658.pf7eg5x5bdhndxkg@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Sat, Apr 10, 2021 at 03:56:58PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Sat, Apr 10, 2021 at 06:34:55AM +0900, Nobuhiro Iwamatsu wrote:
> > > > +static int visconti_pwm_remove(struct platform_device *pdev)
> > > > +{
> > > > +	struct visconti_pwm_chip *priv = platform_get_drvdata(pdev);
> > > > +
> > > > +	return pwmchip_remove(&priv->chip);
> > > 
> > > I think Uwe would prefer this to be done separately because he's working
> > > towards removing the return value from pwmchip_remove() and if we start
> > > ignoring it in new drivers that will make life easier going forward.
> > > 
> > > So this should just be:
> > > 
> > > 	pwmchip_remove(&priv->chip);
> > > 
> > > 	return 0;
> > 
> > I understand your suggestion.
> > However, it looks like the pwmchip_remove() hasn't been updated yet.
> > I will wait for the update of pwmchip_remove.
> 
> pwmchip_remove will always return 0 since b2c200e3f2fd which is in v5.3.
> So Thierry's suggestion is safe and indeed welcome.

Sorry, I was looking at a different function.
I will fix this.

Best regards,
  Nobuhiro
