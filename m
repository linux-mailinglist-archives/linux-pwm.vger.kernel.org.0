Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6455DA5A15
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfIBPCl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 11:02:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35573 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfIBPCl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 11:02:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id n10so4281192wmj.0;
        Mon, 02 Sep 2019 08:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=826HRnOO9gkPFIbB6Az28aCXDDsohCiv0HYoetjg0Tw=;
        b=YKK1Dc/t6JefTK6vXu4TYoLNrZTKJMv5Zw6IRA0Fal8fSYaLzlMhLkMyz3jB7oh6WD
         fBg+ljEgDjHzxjRrBxcLDkN+Px+34uFyxdi3HeZbNMHms9QVbRy7QYUtL92aGlUYXL2P
         ME6JyI3pQoZPJg4djWuZllVc3NEiAnmpHVcAymDFyWk2SUBXR0W0tKcRnsVhahUQUkYA
         UpOYhXPgbcc0Q4NbFWGGIaF/I0lxaIMS/rM3R6FMdXyaHKwsAlo5jLVvcZ6YrWsMXVE2
         YyoLprnor68vN4LqQ8PJ+XcxcKs+bOD5FZ8qg04rnjpW0YezQvwoXMm5M0J0cPz/ZQns
         Be7w==
X-Gm-Message-State: APjAAAXWL736BNBexBePCa5eNghoOYHUCXt8ZgqYjiCNVhw4l7giDWnN
        bs5ecBDJNYcmfXL/QnJCDw==
X-Google-Smtp-Source: APXvYqwsFN2l5tkC+JBs24eIH7Pw0qd/XKAB/LcbG00xDIV0/3XXEc7ZO1aOKZ92BEnOCqOMH/fXTw==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr35701342wmc.126.1567436559727;
        Mon, 02 Sep 2019 08:02:39 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id t22sm11681028wmi.11.2019.09.02.08.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 08:02:39 -0700 (PDT)
Date:   Mon, 2 Sep 2019 16:02:38 +0100
From:   Rob Herring <robh@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        David Lechner <david@lechnology.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: counter: new bindings for TI eQEP
Message-ID: <20190902150238.GA30757@bogus>
References: <20190901225827.12301-1-david@lechnology.com>
 <20190901225827.12301-3-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901225827.12301-3-david@lechnology.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun,  1 Sep 2019 17:58:23 -0500, David Lechner wrote:
> This documents device tree binding for the Texas Instruments Enhanced
> Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v3 changes:
> - fixed style issues
> - fixed generic node name
> - (was suggested to drop descriptions since there is only one interrupt and one
>   clock, but I opted to keep them anyway)
> v2 changes:
> - convert to .yaml format
> - rename clock to "sysclkout"
> 
>  .../devicetree/bindings/counter/ti-eqep.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
