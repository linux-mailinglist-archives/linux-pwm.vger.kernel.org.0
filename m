Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0372622B7
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Sep 2020 00:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIHWiz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Sep 2020 18:38:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46708 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgIHWiy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Sep 2020 18:38:54 -0400
Received: by mail-io1-f68.google.com with SMTP id d18so1078397iop.13;
        Tue, 08 Sep 2020 15:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p/1hHUSbtL14Ax0at2DUeNcr9Ny+Csoyhco21r35crE=;
        b=cX9WwNRZsr5luGMsQG022wzXhNe0wv90a/nTbkgq2zxifC4HdfOxCbuy8lALVy1B8G
         IM8irwkLf8EysjKOrpPGqsREoR6U3/LEN3SmgV06kYM0eohvaHM1HXI4ocRuye3/NVdP
         OOboCnQbsy92B4jqu94PzbuFmbmzX/rvleEYVWTwn3+6qgnakBvq5bvlcLhosprm0nMU
         q/ZGm+vSfBvxtKDqh0GCJb25MtCqmZlhqqLN51A6IOVr7x6n29x9tN2JWZd5cYUtPtbL
         Ee6rhFnprkXwr6vCZIhiQg6NBq6Z3u8UVxCJQs+ypdvVXSdcDIrQBwOOm8cExODcLFkc
         C4nw==
X-Gm-Message-State: AOAM530swKCR+ZBLRNX5jvSACVROQbJnLxnIQGRvIUbPfVcK1xCXdMD+
        FDhKMatJfcqpcvkdJN5P5A==
X-Google-Smtp-Source: ABdhPJwocbAoceUdBVjvP517IFwXFz5vHn3glVCmHqzqVj0ZPDFrK4R2n3DaoP4Yy/j/0jNShnsB/g==
X-Received: by 2002:a6b:3e06:: with SMTP id l6mr1023062ioa.160.1599604733487;
        Tue, 08 Sep 2020 15:38:53 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a21sm337527ioh.12.2020.09.08.15.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 15:38:52 -0700 (PDT)
Received: (nullmailer pid 1066114 invoked by uid 1000);
        Tue, 08 Sep 2020 22:38:46 -0000
Date:   Tue, 8 Sep 2020 16:38:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: renesas,pwm-rcar: Add r8a774e1
 support
Message-ID: <20200908223846.GA1066007@bogus>
References: <20200825104455.18000-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200825104455.18000-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825104455.18000-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 25 Aug 2020 11:44:54 +0100, Lad Prabhakar wrote:
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Document RZ/G2H (R8A774E1) SoC bindings.
> 
> No driver change is needed due to the fallback compatible value
> "renesas,pwm-rcar".
> 
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
