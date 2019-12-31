Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A635012D98B
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Dec 2019 15:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfLaOxW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Dec 2019 09:53:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45661 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaOxW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Dec 2019 09:53:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id v28so35360518edw.12;
        Tue, 31 Dec 2019 06:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/MjM9n8lcw4go9hM9V6jfDtkHJJ9OY553EV40YViXc=;
        b=qZop3MAqC3vJeWXvQ48WeOe+IeamgtW3qBOEjDwmEpVxBcnmJMTPgqOyQjUAtfN4ws
         vEIG7JargoFBvhQ9uuWn4t6Fh7zgo5kHmkDFP+pdZB1+gbIfvRiEY+1YcStU57vtJCOR
         cCM9RJ1nExvM2Fb4OTh3RUlCARr00OQfescAOxBB7kGwB8ni49HlpP3hqrbEFEkL853I
         qEDOGbXotw0i9Wb/p/mqsXIQ9hLInoXcG0eIEboa/OaqZq/n7LGouKlUyzdlg+Hl1x1S
         cwnVWh7S94xFfcslXraNfh/ONokmVplLzBH0nv2QDn0mvWBJb8qVgEHMzY0Q4N1TdFOr
         EMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/MjM9n8lcw4go9hM9V6jfDtkHJJ9OY553EV40YViXc=;
        b=BV5ioH4ydtaQWaTScM4D4+PjeBHnefvKc1nBNCHPrFW7sMiVwG4VT25p12F1lcIf/Y
         nUMyX13lfN+lbDIIpxSLJDpVMsbpzPLVlaq2/NCXv/A0gJcJ0Y2iOR34lOXo/4pBoujL
         lwD6N/oQOKUiBpIX4i+6cNWzUaOExCWICqghFxRIQbCU3Kz6rQxapr1N8NV4c9jxZ4TM
         BKIu+OfUPwfcS3QZ3gTQFq/7uCtpjnBNSk6oh6ObVYBnpaLQV/GelDCLYl0cofiOZgv7
         I3hLXpkOy3GjX9j+i54sc3P2XDdTLzWtKIX1XgJD75n0iDXgR4Iq7Bl+97N/zeff9UmL
         YCDw==
X-Gm-Message-State: APjAAAU4v7Mo8FyRxvPxboxCKpPQMlKVifLRssBZW+S6Xm6D85jUXbBI
        N7xJknn7FHJGI9vIxA7HNpF0HNG4M3WvtDw7rQQ=
X-Google-Smtp-Source: APXvYqwmgH8ITwrdnbYcdkYHW7Lk6bOY4+gRvm+01zIYN0XFhQlFKFAcuRI5Kn2qdPxicg93ogpO/C0grXYHfQadKM0=
X-Received: by 2002:a17:906:339a:: with SMTP id v26mr77372625eja.2.1577804000760;
 Tue, 31 Dec 2019 06:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20191229080610.7597-1-tiny.windzz@gmail.com> <20191229080610.7597-14-tiny.windzz@gmail.com>
In-Reply-To: <20191229080610.7597-14-tiny.windzz@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 Dec 2019 15:53:09 +0100
Message-ID: <CAFBinCDQGGyYxDS9L5iJQpXMpp_+7WW227jVcxWcHhEWcUJLbA@mail.gmail.com>
Subject: Re: [PATCH 14/32] pwm: meson: convert to devm_platform_ioremap_resource
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        nsaenzjulienne@suse.de, shc_work@mail.ru, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        matthias.bgg@gmail.com, heiko@sntech.de, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mripard@kernel.org, wens@csie.org,
        jonathanh@nvidia.com, linux@prisktech.co.nz,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Dec 29, 2019 at 9:16 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for taking care of this cleanup!


Martin
