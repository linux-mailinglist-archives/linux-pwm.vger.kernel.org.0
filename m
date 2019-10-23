Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8782BE1BDB
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2019 15:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405614AbfJWNK5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 23 Oct 2019 09:10:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35592 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfJWNK4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 09:10:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id k2so5018362edx.2;
        Wed, 23 Oct 2019 06:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lzwXfyhUE7yc9zrzbjqMe71sKuHvjq9U3aqm0Bd1AoI=;
        b=S/A3aIGnph7/r49FdcX/+rOROLnuReURWi9z5AaaiFgwNDyHNguoHy2jLTKIg0AobS
         Ii8Aob7iyqUE9px3EJl+QbMXPlHqS2i4AJjUkEXgVYMOpJB5ylqfR28AxSRz0LGrE0oN
         dz0N+b0G4A1+WoZyqXNpZC27TiMgZrwh3OQIocjQVBgN+3XtOoyCaMvlIaqATpBbxqeb
         aH+TRLRapqnj+ldkTcAZ0Bi9oR73bzEGJ0oLBkEdJwU7OEXluqUoH1Bhl4rcsWPwWDMa
         DGF3xhA2WaMsusqyac2NzMIPJnBzhBlKnq/yDYu7/oI4+szOWAtVn2bNxBf1GiYtQfaY
         jRtQ==
X-Gm-Message-State: APjAAAXIBu2F0LkRRidZBYch85DAr88A/27wF1+klG85knTLuwFmQPUI
        Ki2dfON5MI5tkKTRGbG4ylA=
X-Google-Smtp-Source: APXvYqyft44OcCGb0xN0+fC1gmfK8usNRgvA/I5KY4vuTv2zLifQ5kptU9qNo1AQahi2rM4m7Aa/dg==
X-Received: by 2002:aa7:c595:: with SMTP id g21mr36717915edq.79.1571836252860;
        Wed, 23 Oct 2019 06:10:52 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id b12sm785479edq.75.2019.10.23.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 06:10:52 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:10:49 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Lihua Yao <ylhuajnu@163.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Lihua Yao <ylhuajnu@outlook.com>,
        Sergio Prado <sergio.prado@e-labworks.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 00/36] ARM: samsung platform cleanup
Message-ID: <20191023131049.GG11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191010202802.1132272-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 10, 2019 at 10:28:02PM +0200, Arnd Bergmann wrote:
> I've spent some time looking at the remaining ARMv4/ARMv5 platforms
> that are not part of ARCH_MULTIPLATFORM, and tried to get them closer
> to that. Here is what came out of that for the samsung platforms:
> 
> * Exynos and s5pv210 are made independent of plat-samsung
> * device drivers stop using mach/*.h headers for s3c24xx
>   (and other platforms not in this series)
> * s3c24xx and s3c64xx get merged into mach-s3c, removing
>   the need for plat-samsung (I have other patches for the
>   remaining plat-* directories)
> * mach/io.h gets cleaned up to only be needed for BAST
>   PC104 mode (looking for ideas to proceed)
> * mach/irqs.h remains for now, this still needs to be converted
>   to sparse IRQs.
> 
> Some bits are a little ugly, but overall I think this a big
> improvement.
> 
> The contents are available for testing in
> 
> git://kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git s3c-multiplatform

When sending v2, can you Cc:

Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Lihua Yao <ylhuajnu@outlook.com>
(or Lihua Yao <ylhuajnu@163.com> if outlook.com bounces)
Sergio Prado <sergio.prado@e-labworks.com>
Sylwester Nawrocki <s.nawrocki@samsung.com>

These are folks which to my knowledge had working S3C and S5P boards
so maybe they could provide testing.

Best regards,
Krzysztof

