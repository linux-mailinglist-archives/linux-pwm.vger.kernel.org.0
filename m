Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21C61325D3
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2020 13:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgAGMPR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 7 Jan 2020 07:15:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46382 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGMPR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2020 07:15:17 -0500
Received: by mail-ed1-f68.google.com with SMTP id m8so50129815edi.13;
        Tue, 07 Jan 2020 04:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dkoKwK15oscs3r0V8scapeKxlP48dhvoGFKEGuBFTog=;
        b=HXISdLqOXCi/RY0dBfCTadWPxJnegmXUMqSxRGe42iY3pi8cxb8rZbpZSwvcgnrAFf
         rwgszkKeJ18N/gITwyfHV6kEc/vLTbnfoy/TN14I6ftssHKesjXWpAsOHKKWiU7vt+9Y
         WCzrPaEIkDsOAhv0NftJ57trlAAeTUcGoxdEXMm0AM6hGD72Go0f6JEa3x0iJaFSCbOM
         v1sA1a7RPPko6uJ470BeueTPTGbQ9DNQ7fgmal0ow61SD9nFdOnhLtzXLg/nbW6KxWNO
         zFQh8p+avU+PozbeYJ9Ff1qcie3dfq0XoGrsas0HbNTtGPaNwjnBi7YB8bmf/6DlaNkU
         mdlA==
X-Gm-Message-State: APjAAAW2qPasWz1A/X+jNNH83mzzfNkrJNS/TDMj8MdvZ2gTvZEk+7wl
        snpUeEKEQDI0dvFtjcyoAjo=
X-Google-Smtp-Source: APXvYqwW9wXBZpzOMfTBS/kbOe4ZNckfdL5+6WOz5BazFgA1mugpFZqXKx0VrM2wxvGj7bgEnT9msA==
X-Received: by 2002:a17:906:eda9:: with SMTP id sa9mr109435185ejb.297.1578399315230;
        Tue, 07 Jan 2020 04:15:15 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id f9sm7382215edr.66.2020.01.07.04.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 04:15:14 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:15:12 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Weinberger <richard@nod.at>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] pwm: Enable compile testing for some of drivers
Message-ID: <20200107121512.GA319@pi3>
References: <20191230172113.17222-1-krzk@kernel.org>
 <20191230172113.17222-2-krzk@kernel.org>
 <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
 <20200107082539.GA31827@pi3>
 <20200107104234.wq74fska3szrg4ii@pengutronix.de>
 <20200107110359.GA32423@pi3>
 <20200107113354.ggq6zarewq5ip354@pengutronix.de>
 <20200107115429.GA32632@pi3>
 <20200107120926.cgrxk6b4rchf6i42@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200107120926.cgrxk6b4rchf6i42@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jan 07, 2020 at 01:09:26PM +0100, Uwe Kleine-König wrote:
> > > (Oh, HAS_DMA is defined using "depends on !NO_DMA" + "default y".
> > > NO_DMA has three different definitions. Two of them (in
> > > drivers/crypto/ccree/cc_hw_queue_defs.h and arch/arm/include/asm/dma.h)
> > > unrelated.)
> > 
> > Yes, HAS_DMA is the second missing piece for UM.
> 
> So something like:
> 
> 	# Usermode linux doesn't provide HAS_DMA and HAS_IOMEM.  To not have to
> 	# clutter most dependencies with these just exclude UML from compile
> 	# testing.
> 
> as comment for COMPILE_TEST's depend line should be fine, right?
> 

I think yes.

Best regards,
Krzysztof
