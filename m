Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F72851CB
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Oct 2020 20:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgJFSms (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Oct 2020 14:42:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45656 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgJFSms (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2020 14:42:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id f37so9706106otf.12;
        Tue, 06 Oct 2020 11:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KYQZSGGUfzjIz2aYKUs4zyuEx7lVqSUr955zVXov5rY=;
        b=flwZuX5krL2lcEDMeNqXfrgvqq0Lzdi5gt+dlBkp/eAvmSlczrb3Vvo2fADyiRptGL
         tfAPUbcjZqnmfZCmwAVCn1O0ifH9o6awl7qJhYIQQ2wH1JCTi3Oks1f0MUU9Rlhwo9PT
         iQ5C3EAavH5la1iw0Ml43zay/0uNOjl1CIuYDDagIeU8PRzXBeDYSThmJqTWmxF5ooTh
         yO0lU7N9ybsPjdmovmG5naX9WqCY+nnaaUdlo5U4WB61ni4rpbqDd9cMdBZafBTfZAE/
         Bsfe7GtCuarldNvCtkweyU7thFQoTK1+zBe+7lqdvOzCQficflmVQ6DHofIdJZnsZqXh
         uNKg==
X-Gm-Message-State: AOAM531Kan4Wkiz3m+vv7bPZn7nOmYyqEbMH1+BRPtSBCk+bRxPNPwBN
        P3v+DhR7J4FY9y8L80j0VAppsiXdHrsf
X-Google-Smtp-Source: ABdhPJzom6MO5LWQIj8s1jNk3KH+WH7DxMxNrz6HBIoFb0hig8R0gSLa3cSfIY9gZ7i9CWnFNxoOpw==
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr3616282otq.240.1602009767007;
        Tue, 06 Oct 2020 11:42:47 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b1sm1413987oof.8.2020.10.06.11.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 11:42:46 -0700 (PDT)
Received: (nullmailer pid 2610374 invoked by uid 1000);
        Tue, 06 Oct 2020 18:42:44 -0000
Date:   Tue, 6 Oct 2020 13:42:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sagar Kadam <sagar.kadam@sifive.com>
Cc:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, linux-pwm@vger.kernel.org, palmer@dabbelt.com,
        jason@lakedaemon.net, yash.shah@sifive.com,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, maz@kernel.org, mturquette@baylibre.com,
        devicetree@vger.kernel.org, sboyd@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: fu540: prci: convert PRCI bindings
 to json-schema
Message-ID: <20201006184244.GA2610231@bogus>
References: <1601393531-2402-1-git-send-email-sagar.kadam@sifive.com>
 <1601393531-2402-2-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601393531-2402-2-git-send-email-sagar.kadam@sifive.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 29 Sep 2020 21:02:09 +0530, Sagar Kadam wrote:
> FU540-C000 SoC from SiFive has a PRCI block, here we convert
> the device tree bindings from txt to YAML.
> 
> Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> ---
>  .../bindings/clock/sifive/fu540-prci.txt           | 46 -----------------
>  .../bindings/clock/sifive/fu540-prci.yaml          | 60 ++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
> 

Applied, thanks!
