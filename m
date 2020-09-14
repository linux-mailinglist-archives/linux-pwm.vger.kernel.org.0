Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13762696C9
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Sep 2020 22:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgINUQa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Sep 2020 16:16:30 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41479 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgINUQ3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2020 16:16:29 -0400
Received: by mail-il1-f193.google.com with SMTP id f82so806645ilh.8;
        Mon, 14 Sep 2020 13:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1a7lUNJSBLrVXG4F7F2y0e5PmdVZngGKciceNdaM5U=;
        b=UhJoREZZO0qJLl9O76igRDOvum621MIm4eHd48X3NQwq9kJCKZq9r/2LgaaXfkaPRd
         xDClPDr1cj5WAJ/b4OF2vYecXlNb/dMngX5j8CWbIzj9eOBlpQUTEgWLLZJqz9DDD6bq
         PVHhm8tINx18JluOxGgjsY5Y1LcNYZImlRQFhOesKvenNKPdseerl3aWC2s5qfnJ+Q6L
         9+i4pnmTcOyNtOBNnlqXq8oSeXfi3s3UtmJCLATbhiHCSUUBzWEkAsYN8Bn9PfqefcyK
         4oxPe38lNlu6Z+EAJEEvkZTVoUXx5ecT4cjsqwbAco0nJoiGOaXu8pJa14nlycNM+8L1
         +NBg==
X-Gm-Message-State: AOAM533NgPzk7AJ03dpR721vY6448uTNhIGOCFQF2TzpgnDRSE8fBcLg
        7YRivknxiN8+OAJ7nUNQcg==
X-Google-Smtp-Source: ABdhPJxztTbv290OaW1Td1tW8xyYyVpPez3jAxNbv7RIsrs40fpjEVtg/clWhJtjcB7nlPW1fonVxw==
X-Received: by 2002:a92:1a48:: with SMTP id z8mr13376526ill.95.1600114588765;
        Mon, 14 Sep 2020 13:16:28 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i144sm6363902ioa.55.2020.09.14.13.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:16:28 -0700 (PDT)
Received: (nullmailer pid 167223 invoked by uid 1000);
        Mon, 14 Sep 2020 20:16:27 -0000
Date:   Mon, 14 Sep 2020 14:16:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     u.kleine-koenig@pengutronix.de, kernel@axis.com,
        oliver@schinagl.nl, devicetree@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add pwm-gpio
Message-ID: <20200914201627.GA167169@bogus>
References: <20200902121236.20514-1-vincent.whitchurch@axis.com>
 <20200902121236.20514-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902121236.20514-2-vincent.whitchurch@axis.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 02 Sep 2020 14:12:35 +0200, Vincent Whitchurch wrote:
> Add bindings for the pwm-gpio driver.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  .../devicetree/bindings/pwm/pwm-gpio.yaml     | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
