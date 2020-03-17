Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07421885DB
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 14:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCQNey (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 09:34:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46348 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgCQNey (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 09:34:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so9285136wrv.13
        for <linux-pwm@vger.kernel.org>; Tue, 17 Mar 2020 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Z+MKHW669WEkjd/iNBh7MeO0SsbRIG9idSMvjhyzbiM=;
        b=KsS6p0MSp52TQAcG7pvBldUBF4ekSYc5JYV6QQ25LYZtQM+GqD03+hDirW88u+gcB8
         i1g1ttt45YwZpoH3hjyZl4FIrK4b4qHgndHYQylhjojW0lVnobwze1ck8wlLy/XOTi8K
         1/HUrbQYGcLlGNCRXu7lDrkKVJFeYDXfkS48I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Z+MKHW669WEkjd/iNBh7MeO0SsbRIG9idSMvjhyzbiM=;
        b=LB7zQ+huvuJ938LmdHq+ve9n9wGXk/cZa/zh8/XqPVBMaP9WCANpvgE2q8ID8qaU8y
         myl0paMKKn4IoHx+nHsz9mu0ylPhHDMmVkCVNOaVU/lG/qRABbKJyyAhCkHKEACy82lp
         T0eP6umH74WFxQymcoEwVRDUCSnV5GCLGI5kEfNb+hJ+0FARtklKb+o4Hx+pe+DapnNk
         FCBjhR5mSRfSJqYYkehT77MIfvKcqW4bXlOTeBjTxRAXqva6L+UJDEqweWOFCf/8tqts
         nwB1fr9riooljSEGQOtKABQ/1QFX2TkkqExwXqmyPWjX/xYs5Y9IMi+K/EtY26Mu005+
         SCTw==
X-Gm-Message-State: ANhLgQ3flIZwy3QItSjVJ/6gKaU06+/GmNM31w4+MRyVje0591dXyxK5
        csxSULvhiIGvVEu2XePgtMdfiQ==
X-Google-Smtp-Source: ADFU+vvJjTHmfHQo38ivXXn/g9YSOLIfUDH6jMyjCpk9QGccwR5GHnql6GYdWNxMSbtwzbwStHLX+w==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr6080882wru.253.1584452092645;
        Tue, 17 Mar 2020 06:34:52 -0700 (PDT)
Received: from ub1910 ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id n6sm4003655wmn.13.2020.03.17.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 06:34:52 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:34:50 +0000
From:   Paul Barker <pbarker@konsulko.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Message-ID: <20200317133450.58c25bcb@ub1910>
In-Reply-To: <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
        <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
Organization: Konsulko Group
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 17 Mar 2020 14:32:25 +0200
Oleksandr Suvorov <oleksandr.suvorov@toradex.com> wrote:

> The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> Rename it to PWM_POLARITY_INVERTED.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Looks good. PWM_POLARITY_INVERSED confused me when I was working in this area
recently. After applying to master there's no more instances of
PWM_POLARITY_INVERSED in the source tree.

Reviewed-by: Paul Barker <pbarker@konsulko.com>

-- 
Paul Barker
Konsulko Group
