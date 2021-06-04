Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938AF39C2E7
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jun 2021 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFDVve (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Jun 2021 17:51:34 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40546 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFDVvd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Jun 2021 17:51:33 -0400
Received: by mail-ot1-f54.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso10483472otu.7;
        Fri, 04 Jun 2021 14:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AyI3Bv7v3Pj1ilSBOJvpQtV6ge00H/vUNYRyVuGjTgc=;
        b=JsO6yW6cKNpFxsM3QR+iN/IkSc5SFkgp6StYnkhD240KArP4DY+snhPT76wpWSHtvM
         8ZX/0dGkc6NbiuB20IeYxJRKdSy4W1L1uBXFbrP9/lRrHEXVTB1pnX0SQ8TIDg4G7GGN
         XgMKa0+y5xc3E+sHgibn++FfslnGLNqmGfR7+Xb0bjUCMcuOk0Pcf+1ME2tcB5lgK52A
         rPXJkbdhYpMj9QPL5FH/PJrMTudoOQyVau9p/dYxY2nDsaVtHLWdoqPNWfqbQmTHZknY
         HbNVEXsh4lRRDJfsoxXcFmPzyN9hdOIX81L2E8R0HVLiriDadv4oQNlb2f4umyevangj
         7zHw==
X-Gm-Message-State: AOAM531Yox9RIJHXnVCs7zPvAgZmUyjU4Amr5ObdnWelJuAYSL0y94cW
        g0wwXqKyRBfQ3fM5SoqwysVhdzaNJA==
X-Google-Smtp-Source: ABdhPJzgKjQvnY1oVboaSEVe4Fzh5yMgnaGgbt4UfLSWg3miomKHxnK8p6XELinXE7k8xPpteuFJBg==
X-Received: by 2002:a05:6830:2011:: with SMTP id e17mr5307866otp.295.1622843374660;
        Fri, 04 Jun 2021 14:49:34 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y66sm342726ooa.48.2021.06.04.14.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:49:34 -0700 (PDT)
Received: (nullmailer pid 3984835 invoked by uid 1000);
        Fri, 04 Jun 2021 21:49:32 -0000
Date:   Fri, 4 Jun 2021 16:49:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh R <vigneshr@ti.com>,
        u.kleine-koenig@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        lee.jones@linaro.org, tony@atomide.com,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        thierry.reding@gmail.com,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: pwm: pwm-tiecap: Add compatible string
 for AM64 SoC
Message-ID: <20210604214932.GA3984784@robh.at.kernel.org>
References: <20210601102804.22152-1-lokeshvutla@ti.com>
 <20210601102804.22152-3-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601102804.22152-3-lokeshvutla@ti.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 01 Jun 2021 15:58:04 +0530, Lokesh Vutla wrote:
> Add compatible string for AM64 SoC in device tree binding.
> IP is compatible with ti,am3352-ecap, so adding the AM64 compatible
> under enum of one of the compatible list entry.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
