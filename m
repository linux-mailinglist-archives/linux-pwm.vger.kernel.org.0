Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8112412E393
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Jan 2020 08:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgABH5e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Jan 2020 02:57:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55885 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgABH5d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jan 2020 02:57:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so4844697wmj.5
        for <linux-pwm@vger.kernel.org>; Wed, 01 Jan 2020 23:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UanL6Xg19x3IJk9ON7AVf5trQLWWaJ2V1mNFz4i2lZQ=;
        b=APZhCqey6B4qED7ETGokXrNnEuOyR9M5iVHr7TkJbN/kb8pcr8dKqESIq+m5v4Pbka
         LbMt4U7DquYpX6+tWDKArajARZhgiWeg/xAh+/G3yG81hHEclX6mo0LKYKUazrx1+vQ0
         x12VU1OnfcIX3RqaGrvFyq1zr+Db2M5rYFdsqixq/cr20JaHii0Trkkq5LnQQ2IL0gr1
         PB70YfwF0+1nwPKzATao4i0beOSWDbcOEEOZ9BeGrZl2MX7fm4bfcVegCMLWctshM6kk
         eHHZoEL/LoYpD/LUPTsSRQVcrnaPlp+ZEFwaeYieogUeXpQzp0H2sSPylvgcXqDPZf6B
         M/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UanL6Xg19x3IJk9ON7AVf5trQLWWaJ2V1mNFz4i2lZQ=;
        b=gtmOKRLB0e2FFFY3oNfX7Nb9UnO8A18qBkBTT5qryOL/5FVGRKKtUl1OcXqZaEbdX+
         oxvWKhu5ZdPyIGGy5ATw7E1rRMAmAXHdObppJx/Cn0tQFXMmj8yp+ul/teLtqX76tcoy
         tCYB9TmGwwKfu66m3tMavFaGcFEgGtsC8uzAPUH8uSwvzA3CZlOI+rrGXWYy1UBdrDEM
         VfbH8GbDnziAb9f42eZtbWkYuTtt4CPQskvOw56pMQ5eQtOfBGJW2ZwwffTUVu15DXNf
         qUoU2xn35QEaUbhWUk4n0K1JBkkpoTzZnOanzUqXV62PVFeLWbmZrJUAIbYWEQbXviw+
         qpGw==
X-Gm-Message-State: APjAAAVyMbMJleZ8tRkLeVzOEJMO3nQkGM83nxkLtTyLa1jQjRMd2PXH
        St49rdjVg/7UKrVA9/cK17m+/g==
X-Google-Smtp-Source: APXvYqwwGNguWVcv79X0HETbGo9RlTIwQoUP0B3nLtlPehl4xsbv/YUXMNe/5ajm92azqw8ypm1rvg==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr12871982wml.103.1577951851625;
        Wed, 01 Jan 2020 23:57:31 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id f1sm55533281wru.6.2020.01.01.23.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 23:57:30 -0800 (PST)
Date:   Thu, 2 Jan 2020 07:57:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2 7/7] iio: position: Add support for Azoteq IQS624/625
 angle sensors
Message-ID: <20200102075743.GA3591@dell>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-8-git-send-email-jeff@labundy.com>
 <20191215165328.789e8a16@archlinux>
 <20200101225058.GC14339@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200101225058.GC14339@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 01 Jan 2020, Jeff LaBundy wrote:

> Hi Jonathan,
> 
> Thank you for your continued support on this project.
> 
> On Sun, Dec 15, 2019 at 04:53:28PM +0000, Jonathan Cameron wrote:
> > On Mon, 9 Dec 2019 00:38:41 +0000
> > Jeff LaBundy <jeff@labundy.com> wrote:
> > 
> > > This patch adds support for the Azoteq IQS624 and IQS625 angular position
> > > sensors, capable of reporting the angle of a rotating shaft down to 1 and
> > > 10 degrees of accuracy, respectively.
> > > 
> > > This patch also introduces a home for linear and angular position sensors.
> > > Unlike resolvers, they are typically contactless and use the Hall effect.
> > > 
> > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > 
> > Looks good
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > My current assumption is that Lee will take this lot via an immutable branch
> > in MFD once it's ready.  Shout if a different path makes sense.
> 
> Same here. @Lee, please let us know if you disagree.

That's fine.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
