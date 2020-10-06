Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909F72851D4
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Oct 2020 20:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgJFSoG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Oct 2020 14:44:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32877 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFSoE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2020 14:44:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id m7so13701484oie.0;
        Tue, 06 Oct 2020 11:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QPuBu1BxS0jmnEo7HpZE3PSY1Wh/IlpmREYij20Z0dU=;
        b=K/n0SMfPpT7SJ+Gmao4KjIs5GfP3nA6puvvk+/1rc3zzDsOJ80HXAg0iPHzBfpdEqh
         0YeYiVy18qGL8FuqWfVhvP0WHiy+urVYm/yAUqAS8RHMm3D4xywtXfLB0fPpqpw73OIa
         xk/7nhRArMEuRijiaXT8DGdNsUZl6Z7GpO2AWnjRJaLEW0/ltHWGuNrbgkUSj33LSTSk
         6LNkFi9lzfARugFv5qoUKSZhVO+3LsfUQl886EDsOAA4fOVt2eTDl24tIU74zcDeHd3R
         oiUz15o3Cj/Sv4T2mNg3URzSe7CMzp9qLzzZddRGXXWptFrccLljfQH2QyQ1iODPWLmJ
         PVOg==
X-Gm-Message-State: AOAM530alB4EBzNZUYRWQMR7oeFX5Ui63caAPJbtOkpVKDqdPz74cXsH
        Pqg7xIYSlIv0pW8Y0Fjr7A==
X-Google-Smtp-Source: ABdhPJz6Th+dbt15TLclLFiiDoMAIpndrkDTFe1hRaVx5++j8iJOWfP0J8cvUjxibMsRWna3mkmf/A==
X-Received: by 2002:aca:1007:: with SMTP id 7mr3484570oiq.63.1602009842213;
        Tue, 06 Oct 2020 11:44:02 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i5sm1467898otj.19.2020.10.06.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 11:44:01 -0700 (PDT)
Received: (nullmailer pid 2612500 invoked by uid 1000);
        Tue, 06 Oct 2020 18:44:00 -0000
Date:   Tue, 6 Oct 2020 13:44:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sagar Kadam <sagar.kadam@sifive.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, paul.walmsley@sifive.com,
        thierry.reding@gmail.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@dabbelt.com, lee.jones@linaro.org, tglx@linutronix.de,
        yash.shah@sifive.com, jason@lakedaemon.net,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: riscv: convert plic bindings to
 json-schema
Message-ID: <20201006184400.GA2612444@bogus>
References: <1601393531-2402-1-git-send-email-sagar.kadam@sifive.com>
 <1601393531-2402-3-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601393531-2402-3-git-send-email-sagar.kadam@sifive.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 29 Sep 2020 21:02:10 +0530, Sagar Kadam wrote:
> Convert device tree bindings for SiFive's PLIC to YAML format
> 
> Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> ---
>  .../interrupt-controller/sifive,plic-1.0.0.txt     | 58 -------------
>  .../interrupt-controller/sifive,plic-1.0.0.yaml    | 97 ++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> 

Applied, thanks!
