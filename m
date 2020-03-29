Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B427196C95
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2020 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgC2KqB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Mar 2020 06:46:01 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35574 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgC2KqB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 06:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/F8TTmllRhQAieNs3H3r8cSkUpyHMpQ7aHdeJZxCxpM=; b=TB6dAUe3IsgMBI6Ss1SOI4z8L
        iac0Z1lLbuGhAexjYOp5axmyd+W0FmsuQDlca1oJABLPoEnb9A1331CkamBfrf1SJ83HJ3ujKC4tV
        B6tWsnbTJ39myLy8PsrP/z5wv8MDpFyyJfUaViS/+Kvvj6PQR6Gt2SnKPmsc01iZAQPzymakS/Bca
        q3QjXQ6jJ3ZPMHat+HSkYyLE9eZeexB/ljHkjeidBsAQ0loa8qdIDZIVtAkVBtwZwl4bSl9CajQBw
        CmkPgfkTYALEkXIzzyKNa0/5UHt0DEFc96K0ItTUsUcfMMhn6iWnjsT0FIzgdTj1fRPfyqBbLwQA2
        E+fryUP1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42874)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jIVRy-0004UG-CK; Sun, 29 Mar 2020 11:45:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jIVRu-00069D-2a; Sun, 29 Mar 2020 11:45:50 +0100
Date:   Sun, 29 Mar 2020 11:45:50 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Message-ID: <20200329104549.GX25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

This series adds support for the fan PWM output on the Clearfog GT8K
platform, and can potentially be extended to the Macchiatobin.

The cooling maps are experimental - it seems to work well for me
without the fan speed varying too much, but what I've noticed with
fewer entries in the map is instability in the fan speed - it
continually toggles between two fan speeds as the temperature
rises and falls due to the different fan speed.  Hence, this is more
for discussion at this point (and in any case, -final is likely to be
released today.)

 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     | 125 ++++++++++++
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi      |   6 +
 drivers/gpio/gpio-mvebu.c                          | 220 ++++++++++++++-------
 3 files changed, 275 insertions(+), 76 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
