Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DCD4A5038
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Jan 2022 21:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbiAaUgY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jan 2022 15:36:24 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:50606 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378991AbiAaUgX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Jan 2022 15:36:23 -0500
Date:   Mon, 31 Jan 2022 20:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1643661380;
        bh=7sgtGwDga/o8Ab/JfLuKC7BO+Gxeuffi86RawYOpgeo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=blTJJ/irn12fzUUqtso0uifPhBu6XJnXhKyuqVnPiuwZxPglxZwRz2KsOE98NwVQ1
         PpggY2dL4G++ac4UandAdkwZ9w/ibNa2okWhNpJL3jy0oBsXJDa4aNsp5KoVUPikY9
         i9drXveUP7oFcmVmoAYS3wh4gfc4xcwdyTkurGGNJfPjVJa5yfK650P2bRSF/FFUxW
         90rhfqV+l4hWmG1r24N6dqVXDapXbv74Vcg45c3b9OOLIKuk3A0ji44xpv6v0rn49S
         iosLUXpfILba9b22hB1GE9qgexOTn7xnK5sOlJoSj3tDl6P7dLApD4ci3kwXrNTKGU
         oc8IAF7F2c01w==
To:     Javier Martinez Canillas <javierm@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
Message-ID: <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
In-Reply-To: <20220131201225.2324984-1-javierm@redhat.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,T_SCC_BODY_TEXT_LINE
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This driver only advertises XRGB8888 in ssd1307_formats. It would be nice t=
o
expose R8 as well so that user-space can directly produce suitable buffers.
It would also be nice to have some kind of preferred format, so that user-s=
pace
knows R8 is preferred over XRGB8888.
