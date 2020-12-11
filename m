Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E732D6EE1
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 04:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395222AbgLKDsY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 22:48:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45383 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395229AbgLKDr4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 22:47:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id h18so7081595otq.12;
        Thu, 10 Dec 2020 19:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwzlRu7XT64jzkln5zNA8fU/0gIXgr88ZmNCsytqy8k=;
        b=koIwS9rWqEn/kHlRLpoOiJJZMsKjvBYWD1QjDS84D5/U094L1g/YLN6dsVvEjV9xJ6
         uQ8r+tmQq6/xr0lGOgSBjNvlNe44kwqgk7DvzgCZ0lvMzSJFXsMkindWC5tBA4nSk6tN
         mZUw810i+Kvtl0EuVdZfHM6yrd3oBo4JQjq20hRABq9HfOpi2nkZep+nbf5qKE9J1YlS
         id5TwARSyiZ1on8OYrAPEZCSZ+My8WAmLFh2Ilk3N5nrrG7O2Ds8IuLf0QrmMhFx3S1J
         h/IWOMO2PnXkyDOrdx3JzxEptGnL3a4aPaSdyl2CMc/ximTDuJvwR6SkbgN78ZoNPjFc
         Rb0A==
X-Gm-Message-State: AOAM531WBCBNfljpavlbG/usVDRePB+yDFgfDV+uFTWkAWB8OLpDnWHW
        L2nse1TT0C8Xpu3jtUpgDQ==
X-Google-Smtp-Source: ABdhPJygjoh6SmZ/btWfAkyVXnqcEeardEM0RdNav2rSCXwN4/B/XBR7OLLAq9AjNOH8/HnTPoz85g==
X-Received: by 2002:a9d:2de9:: with SMTP id g96mr8336782otb.209.1607658435276;
        Thu, 10 Dec 2020 19:47:15 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm759177oov.23.2020.12.10.19.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:47:12 -0800 (PST)
Received: (nullmailer pid 3603636 invoked by uid 1000);
        Fri, 11 Dec 2020 03:47:10 -0000
Date:   Thu, 10 Dec 2020 21:47:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 3/3] dt-bindings: ap806: document marvell, gpio
 pwm-offset property
Message-ID: <20201211034710.GA3603606@robh.at.kernel.org>
References: <cover.1607601615.git.baruch@tkos.co.il>
 <5c2810b698c5099264b82a7f6fbed13e66062307.1607601615.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c2810b698c5099264b82a7f6fbed13e66062307.1607601615.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 10 Dec 2020 14:16:00 +0200, Baruch Siach wrote:
> Update the example as well. Add the '#pwm-cells' and 'clocks' properties
> for a complete working example.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  .../bindings/arm/marvell/ap80x-system-controller.txt      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
