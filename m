Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788A12248EF
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jul 2020 07:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgGRFSu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 Jul 2020 01:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgGRFSt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 18 Jul 2020 01:18:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84576C0619D2;
        Fri, 17 Jul 2020 22:18:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so6290869ple.0;
        Fri, 17 Jul 2020 22:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=mlfozsoeSwNR4jerQErJFdBhmV0KjCymWwxCPubYIaA=;
        b=bJyEKfCPgI1GtaOteGEWzVV0x2CRPEvQOeStpeHpBoUvnK5R1hBYenSXTnShj2gVan
         OAXaYHXKzDkwWwjJOkHUgLZdLYhgODNAzKKdMyIGUVeIclj/VI8CJrz6eaaCu3Zg/DUo
         0e/3AjCnrMhq3VO9xYbstzE7ObX8S6F4gNdl3QDOSh2Z9yhNqKsFhsj1Lawte6q1wWKQ
         aqaQcRcLaJYqekfnfpOObfFk+8HM+8YO0Si2qq5f1MFV9K1JG+aGHVOlHvVswUr8ZZkF
         PJ9j4RxFQMWmeYdJLsZ4xL/+//mski0uxYNP+E9v9KbOn17EVmHrUBlEXqx1rd4PHUAA
         SdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=mlfozsoeSwNR4jerQErJFdBhmV0KjCymWwxCPubYIaA=;
        b=L7qxRXpLlrg0E8ePPgaKiQFT3OAOpKCXRkqoXO7N6JODm0iJw6aD0FFSHM5Wi2IGgM
         Y1Uce3bFt0ufB1GpgZdBEPTePzPs23Qyy6UKmCxD+lM9KNS2laKpXjnr5fN1ZQZMvYTP
         wJZVm3DTKOkWm3zTPhsm2f2dkuUGQBNayTXwMoXbvkQT4/5DgEtv7gCLADEb78lloZe6
         QbxiIRwE2Toxsi7NM8kxxNCti08thTV2SuS7jb5ZC0UPG4bHsVVNWC2DIe286/PtGTL0
         fcyBOPiIL45YniQ7uHLsr7osu88yab7+F1hbGILskF9+pjiGGCvuxhp9xth9oyN7UYBo
         yoZw==
X-Gm-Message-State: AOAM5303Bh4ygjqwpKX97V3xFmH0Dnti5xk/Y1x7aeKiYHlTqdpkcNQm
        tg4DthjTEvagP6f7Z5MWnc8=
X-Google-Smtp-Source: ABdhPJx+qV5tP7OduXb9qq/p372Wy7fK9H763iy8HSM4aIsKs/6vD63FNgE7DS+Nru7djfo1eoK6XA==
X-Received: by 2002:a17:902:d704:: with SMTP id w4mr10626957ply.278.1595049527861;
        Fri, 17 Jul 2020 22:18:47 -0700 (PDT)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id 137sm9381988pgg.72.2020.07.17.22.18.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 22:18:46 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v4 05/20] backlight: improve backlight_device
 documentation
Thread-Topic: [PATCH v4 05/20] backlight: improve backlight_device
 documentation
Thread-Index: AQHWUWo8LdMENsI4A0SJ70NDIxdujKkM4vEa
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Sat, 18 Jul 2020 05:18:39 +0000
Message-ID: <SL2P216MB0105B428FFAB66BDA245B814AA7D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-6-sam@ravnborg.org>
In-Reply-To: <20200703184546.144664-6-sam@ravnborg.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/3/20, 2:46 PM, Sam Ravnborg wrote:
>
> Improve the documentation for backlight_device and
> adapt it to kernel-doc style.
>
> The updated documentation is more strict on how locking is used.
> With the update neither update_lock nor ops_lock may be used
> outside the backlight core.
> This restriction was introduced to keep the locking simple
> by keeping it in the core.
> It was verified that this documents the current state by renaming
> update_lock =3D> bl_update_lock and ops_lock =3D> bl_ops_lock.
> The rename did not reveal any uses outside the backlight core.
> The rename is NOT part of this patch.
>
> v3:
>   - Update changelog to explain locking details (Daniel)
>
> v2:
>   - Add short intro to all fields (Daniel)
>   - Updated description of update_lock (Daniel)
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
 > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

It looks good!
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

For the rebase, if you don't know which branch of maintainer's git can be u=
sed,
linux-next tree [1] is useful. The linux-next git collects all next branche=
s from=20
other maintainers' git every day.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/

Thank you.

Best regards,
Jingoo Han

> ---
>  include/linux/backlight.h | 72 ++++++++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 23 deletions(-)
.....
