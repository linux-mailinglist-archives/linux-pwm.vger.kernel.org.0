Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5229D52B
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Oct 2020 22:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgJ1V7D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Oct 2020 17:59:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46054 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbgJ1V64 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Oct 2020 17:58:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id dg9so1021849edb.12;
        Wed, 28 Oct 2020 14:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tOSSVd6g+cSizugZ+61jWZ/Ke8VauxHbw7IaIWTb/wM=;
        b=Rza44/wdsLqEqIP8FWcraX2QsYrVHcUiX95WU7ENPEVYnB7Z2wp0E39VS/ybPP2HdL
         dIQa+VXBZowTcrWTILYWakpKxLJ3EBFzgUU/cf9n5K3wpkUzh4IN4Mete3GMrZPgvpur
         K64L2imFr3U5ziORFfqXm0GzCCHoIbQwu6Ad0R3Iv23n6MhgwCqWQhYm57zHF/WfJl/S
         LpRyyfSr7sZJCd88UDZ0/cye3ae7OvJPjmQ0QZqi0egZg+N3T7oYJ6hhW6d+vbtkmNHk
         flRKPMxgfulFGpcs6nNsUZqEEgjkOPXUufrNBdXUaw3fClSP2ijbQiZ49Lch8BP7wSnI
         bbIA==
X-Gm-Message-State: AOAM531IvS/2sPBxX3WbOEPJJoTOmvUzcXOpQxV6Evct8alo8IjkLdpw
        4aceF4BzQso6uC3H+DVTwKw=
X-Google-Smtp-Source: ABdhPJyW9XJuiCVh46G8QNJ0uU2aEaphWHdNSrwrao3zAPWmuRSnCeFT3lleDdLhUhoYxLLbsMB6YQ==
X-Received: by 2002:aa7:c984:: with SMTP id c4mr1036648edt.42.1603922334516;
        Wed, 28 Oct 2020 14:58:54 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id f14sm455871edv.79.2020.10.28.14.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:58:53 -0700 (PDT)
Date:   Wed, 28 Oct 2020 22:58:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Jeongtae Park <jtp.park@samsung.com>
Subject: Re: [PATCH 3/4] MAINTAINERS: remove Jeongtae Park from Samsung MFC
 entry
Message-ID: <20201028215851.GC269525@kozik-lap>
References: <20201016151528.7553-1-krzk@kernel.org>
 <20201016151528.7553-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016151528.7553-3-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 16, 2020 at 05:15:27PM +0200, Krzysztof Kozlowski wrote:
> Jeongtae Park has not been active on LKML:
> https://lore.kernel.org/lkml/?q=f%3A%22Jeongtae+Park%22
> 
> Remove him from the Samsung S5P MFC driver entry.
> 
> Cc: Jeongtae Park <jtp.park@samsung.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  MAINTAINERS | 1 -

Applied.

Best regards,
Krzysztof

