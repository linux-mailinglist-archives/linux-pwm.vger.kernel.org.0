Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B6435B8CB
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 05:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhDLDFs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 23:05:48 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:55006 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbhDLDFr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 23:05:47 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 13C354xU001261; Mon, 12 Apr 2021 12:05:04 +0900
X-Iguazu-Qid: 34trpShQI277aZkbf5
X-Iguazu-QSIG: v=2; s=0; t=1618196704; q=34trpShQI277aZkbf5; m=lP9cfn233k75Uk+XzofdsciNBCS2CP+P5GkJetk8OSo=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1513) id 13C353JR017710
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 12:05:03 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 324491000A7;
        Mon, 12 Apr 2021 12:05:03 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 13C352MU012428;
        Mon, 12 Apr 2021 12:05:02 +0900
Date:   Mon, 12 Apr 2021 12:04:58 +0900
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
Message-ID: <20210412030458.t2vhg4nxwyi5yp4o@toshiba.co.jp>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210410185222.4tfpgm2hcka26e6g@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210410185222.4tfpgm2hcka26e6g@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Sat, Apr 10, 2021 at 08:52:22PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> one more comment:
> 
> On Sat, Apr 10, 2021 at 08:08:37AM +0900, Nobuhiro Iwamatsu wrote:
> > +static inline struct visconti_pwm_chip *to_visconti_chip(struct pwm_chip *chip)
> 
> all functions but this one start have the common prefix "visconti_pwm_".
> I like the concept of a common prefix and so you could rename this
> function to visconti_pwm_from_chip or similar.

OK, I will change. 

> 
> Best regards
> Uwe
> 

Best regards,
  Nobuhiro
