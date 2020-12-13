Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4098D2D8B64
	for <lists+linux-pwm@lfdr.de>; Sun, 13 Dec 2020 06:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgLMFOn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Dec 2020 00:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgLMFOn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 13 Dec 2020 00:14:43 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607836443;
        bh=VaeAUus1rNjDVdpneM1XXAW2srOZQ+w5dltPlY5NNS0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TVSR2uV8fXibrDJR0JsFRK2z5DyNUykiQtSg7rHx7t60763vOPg5/eidNeG8tT1zW
         u9zOoF1TQi0lCyDjSJ3GSUHjq44LtCbqOB34mPkWM+k2NbMWZH3KaqGhbF4o780yQY
         6PNWK+rWJ8rCKerWpESwn7BlzoSFe4gv17J2aEVa3OUqvSVfgCLLdWiRu+pK4xkWzg
         WAmafQpCldA8y/U4XSsZD02KWyOhiXyxGsWMQh5qnbTlKd8kxYpHQ3mmH+bBmc2y/A
         v0Gfbv3pUnNrlJsqBY9oNZB4BbXCSU2SIt8hICHfLSKvYpYwqnB751wqsXTZxeeJsU
         1SSrLT9hUv3Sg==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201211164801.7838-2-nsaenzjulienne@suse.de>
References: <20201211164801.7838-1-nsaenzjulienne@suse.de> <20201211164801.7838-2-nsaenzjulienne@suse.de>
Subject: Re: [PATCH v6 01/11] firmware: raspberrypi: Keep count of all consumers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, wahrenst@gmx.net,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Date:   Sat, 12 Dec 2020 21:14:01 -0800
Message-ID: <160783644171.1580929.15619962172135112128@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Quoting Nicolas Saenz Julienne (2020-12-11 08:47:50)
> When unbinding the firmware device we need to make sure it has no
> consumers left. Otherwise we'd leave them with a firmware handle
> pointing at freed memory.
>=20
> Keep a reference count of all consumers and introduce rpi_firmware_put()
> which will permit automatically decrease the reference count upon
> unbinding consumer drivers.
>=20
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>=20
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
