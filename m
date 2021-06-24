Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EBD3B39B5
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 01:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhFXXV6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Jun 2021 19:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhFXXVz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Jun 2021 19:21:55 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA95C061574;
        Thu, 24 Jun 2021 16:19:35 -0700 (PDT)
Received: from thinkpad (unknown [172.20.6.87])
        by mail.nic.cz (Postfix) with ESMTPSA id 0616F140985;
        Fri, 25 Jun 2021 01:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1624576773; bh=8cysa6nT7MI1EWztf8cYuf42iTZFRLwzH+PJ2h+bqdE=;
        h=Date:From:To;
        b=j8c1sGTQ8sv6jgqo3lc1PLIWIv1spJyzsdbMPsNdnIxSYL0GSQbPhFhG28EeS9O+h
         UtUVo0QuaiOpZfZ0FODk9FSZlNgKob3dmqV9vCxMCjb/tckFzZwvLCeaNoe8c3zcTO
         i33iJgI2e/E0iBTuHPX9H5ZDsVUt6pnVVv8onj2s=
Date:   Fri, 25 Jun 2021 01:19:32 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <20210625011932.6354e397@thinkpad>
In-Reply-To: <20210623035039.772660-1-bjorn.andersson@linaro.org>
References: <20210623035039.772660-1-bjorn.andersson@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,URIBL_BLOCKED,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 22 Jun 2021 20:50:38 -0700
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml

The file name should be based on one of the compatible strings, for
example the first one:
  qcom,pm8150b-lpg.yaml

> +      led@1 {
> +        reg = <1>;
> +        label = "green:user1";
> +      };

`label` is deprecated, please don't use in new bindings in examples.
Instead use color, function and function-enumerator, i.e.

  color = <LED_COLOR_ID_GREEN>;
  function = LED_FUNCTION_xxx;
  function-enumerator = <N>;


