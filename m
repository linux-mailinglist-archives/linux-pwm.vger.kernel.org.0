Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E583C372114
	for <lists+linux-pwm@lfdr.de>; Mon,  3 May 2021 22:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhECUEM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 May 2021 16:04:12 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44687 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECUEM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 May 2021 16:04:12 -0400
Received: by mail-ot1-f44.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so2223257otp.11;
        Mon, 03 May 2021 13:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BXQMOsGaQzNajmGabcmfpUaZM+Cpo2YTQ+tBtMthH6M=;
        b=YDi6BnVAI2UWK9v8M6oM/y6RPdGZbDYMUmaB+3GqTwTm2CsDCfpsg0LmTnqDWAKOex
         8iaOPkqwXDtjc/mxJk3YGGmBO/y26jUSg25vY7iF+q+AS9vy23tjjBaTXctzWK7XbL3Y
         fW/6oqvGVtx8OeIRvmCE6dlO7eU7Z0J/fMKZPeBj+0KCt20LW1u+aMpkyEC6Qc5jzEsy
         FGF+WXQT0rm5m7J3m8kXITIo9ZCEAPm++z8J+0eZ617uW9g2UC+KZ6m6LAe4kMtLHmRV
         Pui4nlFc3JeUJmTPVjD9jdkA/F/Zgk3nN4ZWBA4ExHL0HF12QrJOoKbQLdrThFIJnLUd
         E+8g==
X-Gm-Message-State: AOAM532KBpPuz/ONpdZ4wMUum4IFUGmvL9LX33751ItbJTYDalp7rU9/
        RM/rhJ9at0N+F0S197ks6Q==
X-Google-Smtp-Source: ABdhPJwK0Avv9eGfTX3UQnV86HQ8uOJxlDXjyR4jZ0EvBhlmu1jrugj0Fl4Z8av4LKErhFNLBpMaFA==
X-Received: by 2002:a9d:4d9a:: with SMTP id u26mr15902553otk.161.1620072198141;
        Mon, 03 May 2021 13:03:18 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y13sm169270oon.32.2021.05.03.13.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 13:03:17 -0700 (PDT)
Received: (nullmailer pid 2299535 invoked by uid 1000);
        Mon, 03 May 2021 20:03:16 -0000
Date:   Mon, 3 May 2021 15:03:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: renesas,pwm-rcar: Make power-domains
 and resets required
Message-ID: <20210503200316.GA2299413@robh.at.kernel.org>
References: <16e82b5019b913f9a63e312166a37ef67266d425.1619700364.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e82b5019b913f9a63e312166a37ef67266d425.1619700364.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 29 Apr 2021 14:46:45 +0200, Geert Uytterhoeven wrote:
> The "power-domains" property is present on all supported platforms.
> The "resets" property is present on all but R-Car Gen1.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Applied, thanks!
