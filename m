Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F037F15F
	for <lists+linux-pwm@lfdr.de>; Thu, 13 May 2021 04:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhEMCg3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 22:36:29 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:35778 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhEMCg2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 22:36:28 -0400
Received: by mail-ot1-f43.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so12314487otg.2;
        Wed, 12 May 2021 19:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfnH5ox5sIbZsFybiEh4+BvXlULRF03zb/DaICpNQpw=;
        b=azhDMD+jKorZjlG24rOl+GEiyVC4Amhfa1a9VmxI+3VfuvE1S07u18ismXVA1Ijfbb
         Rd5Tr7tpR/QuDwf5oATOqhWMZx67VNerc86cAPFSoLXCdZvffFLIPNnbOpHI/hclxHhz
         XwQKTRNa6XY0lMMzrCR9s1UqbjSEwvwAHa56QQWDhcmNW5c9CutWjXbs/xm3w7XBTMO1
         gl5Iv0ukxG4KrfpGCOoZaVRhK/tvvQiPCuLxo61LpCLLc4uT+0JYteg1UwlVGWms1D/5
         LlhBWnNzueM7r6zlW2dKfckzKiTrc2txcSCtyMOosmuXnSQjXZ/VpSnniKqrcXX6bG1+
         uRsw==
X-Gm-Message-State: AOAM531kECAwyyOW0jtr5GKput35RqM86ciPD98c3FppcimLweUpdJB6
        EU87hzZilsRvXF9qQ0N/9A==
X-Google-Smtp-Source: ABdhPJyZu9UDn0xbfSe6yHeZ+FFvMolE/2vMtP7VEUiqXD7Fqc+X9aYORrK2plMiaOxxFRP4a7OBiw==
X-Received: by 2002:a05:6830:1605:: with SMTP id g5mr32562398otr.22.1620873319079;
        Wed, 12 May 2021 19:35:19 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m81sm383283oig.43.2021.05.12.19.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 19:35:18 -0700 (PDT)
Received: (nullmailer pid 918772 invoked by uid 1000);
        Thu, 13 May 2021 02:35:17 -0000
Date:   Wed, 12 May 2021 21:35:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-pwm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: timer: renesas,tpu: Convert to
 json-schema
Message-ID: <20210513023517.GA918693@robh.at.kernel.org>
References: <cover.1620648868.git.geert+renesas@glider.be>
 <1c33e62c3a74979c3ca9580176e6cf89384caea9.1620648868.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c33e62c3a74979c3ca9580176e6cf89384caea9.1620648868.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 10 May 2021 14:18:35 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas H8/300 Timer Pulse Unit Device Tree binding
> documentation to json-schema.
> 
> Correct clock-names, as "peripheral_clk" is the name of the supplier,
> and all users use "fck".
> 
> Note that there are two different bindings for the TPU, both using
> "renesas,tpu": this one for using the TPU as a clock source (used on
> H8/300), and a second use for using the TPU as a PWM controller (used on
> ARM).  To avoid conflicts, both bindings are marked with the appropriate
> "select" logic, to check for the absence respectively presence of the
> "#pwm-cells" property.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>   - Drop unneeded "'#pwm-cells': true" from "select" section in
>     renesas,tpu-pwm.yaml,
>   - Add Reviewed-by.
> 
> I have listed Sato-san as the maintainer, as he wrote the original
> driver and bindings.
> Sato-san: Please scream if this is inappropriate ;-)
> ---
>  .../bindings/pwm/renesas,tpu-pwm.yaml         |  9 +++
>  .../devicetree/bindings/timer/renesas,tpu.txt | 21 -------
>  .../bindings/timer/renesas,tpu.yaml           | 56 +++++++++++++++++++
>  3 files changed, 65 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.yaml
> 

Applied, thanks!
