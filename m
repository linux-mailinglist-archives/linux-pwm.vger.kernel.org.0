Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1530A3B3F73
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 10:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFYImG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 04:42:06 -0400
Received: from mail.thorsis.com ([92.198.35.195]:44139 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhFYImF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 25 Jun 2021 04:42:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id C61C23593;
        Fri, 25 Jun 2021 10:39:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1foNQkjRn8tw; Fri, 25 Jun 2021 10:39:43 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 4118435C5; Fri, 25 Jun 2021 10:39:42 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
Date:   Fri, 25 Jun 2021 10:39:32 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <YNWWRM+6p/lgJ28W@ada.ifak-system.com>
Mail-Followup-To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
References: <20210623035039.772660-1-bjorn.andersson@linaro.org>
 <20210625011932.6354e397@thinkpad>
 <YNUY9ncs34E6aJMe@yoga>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNUY9ncs34E6aJMe@yoga>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Bjorn,

Am Thu, Jun 24, 2021 at 06:44:54PM -0500 schrieb Bjorn Andersson:
> On Thu 24 Jun 18:19 CDT 2021, Marek Behun wrote:
> > please don't use in new bindings in examples.
> > Instead use color, function and function-enumerator, i.e.
> > 
> >   color = <LED_COLOR_ID_GREEN>;
> >   function = LED_FUNCTION_xxx;
> >   function-enumerator = <N>;
> > 
> 
> Can you point me to something helping me regarding what "function" to
> use?
> 
> For this particular devboard that the example comes from I have 4 LEDs
> that are named "user1", "user2", "user3" and "user4" in the board
> documentation. I can make up whatever for the example, but I would like
> to get the following dts additions follow the expected guidelines.

I asked myself the same question in the past.  The wohle list is in
'include/dt-bindings/leds/common.h' and I in my personal project I
opted for LED_FUNCTION_INDICATOR, but yes, the confusion is real.

Greets
Alex

