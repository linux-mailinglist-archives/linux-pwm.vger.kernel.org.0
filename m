Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C89062DD6
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2019 04:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfGICE2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jul 2019 22:04:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46552 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGICE2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jul 2019 22:04:28 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so39690982iol.13;
        Mon, 08 Jul 2019 19:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXZUHBir01wKZU7m72S+FiHr/yCGvCa1uAUPwxtao4g=;
        b=Q9QE3E6rwb+uVw8djey06dXZuHIaycSrKNtzeihPUhu+cuc0ew0LmXHCzcZmYKFXRY
         uOGNe0cyIe9F109V6aKAAuQsCFIgVO79ro3ta7yo6qgSz0CpEzg1gpzxKa162eKdhSn6
         qCZ0tqZQG34aZaiLGtRGaM34+Jzy5b2+ixnX/dNflgZhhqv5VvJiZDj56obtm+VvstDh
         BsELPCAGaKM8JGVMPPUlp7nQdzzj8OnuK1lqKd7cz4OnRanmEco+wZDLIJE0UJab2kb2
         BIYT98dbqqbbLw2yOlwpatXs3IdelWnhhrBirkc2WkVyU/Uz3d+Jo0WadSEVr6cM90+y
         6fIA==
X-Gm-Message-State: APjAAAXpIZmd0cm3Mku7QTyY4yvqWIZU1Pba6DiymDIe8QHOrEuToHno
        TxW+Igaq7eY0Z6aD+Nfb0Q==
X-Google-Smtp-Source: APXvYqyP35uiyARAwCEQK3dA40fjTAx3jOq6/vIt3BedPGtqqb9uB7dRGP8Nsa9kwgwwSopcG1TmEQ==
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr1224295iok.52.1562637867706;
        Mon, 08 Jul 2019 19:04:27 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r7sm17663560ioa.71.2019.07.08.19.04.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 19:04:27 -0700 (PDT)
Date:   Mon, 8 Jul 2019 20:04:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: Remove unused compatible strings
Message-ID: <20190709020425.GA7984@bogus>
References: <20190607154410.10633-1-paul@crapouillou.net>
 <20190607154410.10633-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607154410.10633-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 07, 2019 at 05:44:05PM +0200, Paul Cercueil wrote:
> Right now none of the Ingenic-based boards probe this driver from
> devicetree. This driver defined three compatible strings for the exact
> same behaviour. Before these strings are used, we can remove two of
> them.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Rebase on v5.2-rc3
> 
>  Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> index 7d9d3f90641b..493bec80d59b 100644
> --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> @@ -2,10 +2,7 @@ Ingenic JZ47xx PWM Controller
>  =============================
>  
>  Required properties:
> -- compatible: One of:
> -  * "ingenic,jz4740-pwm"
> -  * "ingenic,jz4770-pwm"
> -  * "ingenic,jz4780-pwm"
> +- compatible: Should be "ingenic,jz4740-pwm"

Are you sure all 3 chips are exactly the same features and bugs?

The correct thing to do here generally is the 4770 and 4780 would also 
have ingenic,jz4740-pwm as a fallback compatible. Then the driver can 
match on that until you find some difference and can use the more 
specific compatible.

>  - #pwm-cells: Should be 3. See pwm.txt in this directory for a description
>    of the cells format.
>  - clocks : phandle to the external clock.
> -- 
> 2.21.0.593.g511ec345e18
> 
