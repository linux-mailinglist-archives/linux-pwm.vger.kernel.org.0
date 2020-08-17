Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F47247A21
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Aug 2020 00:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgHQWKv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Aug 2020 18:10:51 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:39105 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbgHQWKt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Aug 2020 18:10:49 -0400
Received: by mail-il1-f196.google.com with SMTP id f12so8323602ils.6;
        Mon, 17 Aug 2020 15:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FV71Do6+ddR98mWO5xKm3RuJ/5xQqaLemwdBMVqmXAo=;
        b=etALAuzKtl6oUZGAQN88VeJ/mAmzI0YogCfUx+SpstWgqxsPpvgfcg6raHA5srguNo
         tec5VUz84q3JQJ3xDmxxGoXqL+Qx/VNsd9TM0JUddkFHLpGQaIA6ZyJX9LQTIQ0CTNHe
         bhHe1aWtzVd5zinLiZJtVyPbSDCltBZgrvL+RtsNPSGWw4zXwYTBOW8GachV09GrorBY
         nvJ7ZqXiVQjDwiX0mz8JxhBMT6MrbQq8p7kw61ghkceZHXJ4rt1pyrQ0cT5l+P9BZSPu
         +V5AR+AyENmZDUrJ4iLYkj3nUoSA6+wh7obqqu5fZOnVDcebtnpzH6IWc/AZWOM+uNMN
         QzaA==
X-Gm-Message-State: AOAM5300x34+bqm57343DhY41z34oilWWHga2mOrPRCRmH5pjpDDPikp
        9fmYC4uIW4oya6JNpDpynw==
X-Google-Smtp-Source: ABdhPJyB6SidyKz94Gaxsq4OtzXh2gXZ2ntCkmBG5Iud74qbldnH8x/in1Yz0oyzKaetuNZng0GE0g==
X-Received: by 2002:a92:bad5:: with SMTP id t82mr15563469ill.22.1597702248443;
        Mon, 17 Aug 2020 15:10:48 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id t16sm2865203ili.75.2020.08.17.15.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 15:10:47 -0700 (PDT)
Received: (nullmailer pid 1664783 invoked by uid 1000);
        Mon, 17 Aug 2020 22:10:46 -0000
Date:   Mon, 17 Aug 2020 16:10:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-pwm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5] dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742
 support
Message-ID: <20200817221046.GA1664753@bogus>
References: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200806183152.11809-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806183152.11809-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 06 Aug 2020 19:31:49 +0100, Lad Prabhakar wrote:
> Document RZ/G1H (R8A7742) SoC bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
