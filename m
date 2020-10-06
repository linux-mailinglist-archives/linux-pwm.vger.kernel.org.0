Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441602851D8
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Oct 2020 20:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgJFSpK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Oct 2020 14:45:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46810 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFSpK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2020 14:45:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id u126so13652462oif.13;
        Tue, 06 Oct 2020 11:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gx2hEzPdtZzxVHpX94NR3xMuo2CpHfX+aniPg7cGd7E=;
        b=llY/U+bNH3ibbZGJNOSHL2jyFuZXWML7V2ls9Fa2UACigSs9flWJw+MXDvec2r6wVf
         2gJDaA9fuJ6EVo9mOCQQtT7Mfa/mCY2xpvT+Uwo5TZ7OdVWixXl/0IXnmia/l2YyVplO
         NghlcDsZ+xTfK53u3lNxEQT5O9Wbgf8ZzGww9UFlWDu/BOFz2E8rRO9387vlRzDwkwaH
         HxBzhV1kJEpNVQo50aZgBbAICZ4uH9YcCmsTbfySSDIvsrdmopWwCaVGrtu0C4tQAj60
         Gjdu4ixRJzf0GoZNl+RR0Pg/qanhXo9i7XDxTOp6+tpmdAR1Bh6hZRYwFJGy3LTCnQ3Q
         75gA==
X-Gm-Message-State: AOAM531KedS6p0NHCcSF4GtW82FSO8W3OIJlng6M4GKFWUmKEmc5fjAh
        amGNZeP22nDxEjvRkfKAUn7BzSi17gQ6
X-Google-Smtp-Source: ABdhPJzABpX06X77NC8/qtvdmovZtjI3oABOZsl06LFgqXj16pDUpDxTrxelm5/7+/R+Mqi+oZGlJQ==
X-Received: by 2002:aca:d946:: with SMTP id q67mr3561924oig.27.1602009908148;
        Tue, 06 Oct 2020 11:45:08 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s124sm1494222oig.6.2020.10.06.11.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 11:45:07 -0700 (PDT)
Received: (nullmailer pid 2614391 invoked by uid 1000);
        Tue, 06 Oct 2020 18:45:06 -0000
Date:   Tue, 6 Oct 2020 13:45:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sagar Kadam <sagar.kadam@sifive.com>
Cc:     thierry.reding@gmail.com, paul.walmsley@sifive.com,
        sboyd@kernel.org, lee.jones@linaro.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, maz@kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, linux-pwm@vger.kernel.org,
        jason@lakedaemon.net, u.kleine-koenig@pengutronix.de,
        yash.shah@sifive.com, tglx@linutronix.de,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] dt-bindings: riscv: convert pwm bindings to
 json-schema
Message-ID: <20201006184506.GA2613769@bogus>
References: <1601393531-2402-1-git-send-email-sagar.kadam@sifive.com>
 <1601393531-2402-4-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601393531-2402-4-git-send-email-sagar.kadam@sifive.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 29 Sep 2020 21:02:11 +0530, Sagar Kadam wrote:
> Convert device tree bindings for SiFive's PWM controller to YAML
> format.
> 
> Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 -----------
>  .../devicetree/bindings/pwm/pwm-sifive.yaml        | 69 ++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> 

Applied, thanks!
