Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C00F4A531C
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Feb 2022 00:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbiAaXVr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jan 2022 18:21:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237951AbiAaXVr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Jan 2022 18:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643671306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrT+G3tPg9tF+5XuIAQ32IRnOTQfqMCqOg72JDwqGHg=;
        b=az5rQSicjcNnkTP+5PCfY0d/hlIeIXcmwsiHxr7eKNMPJLB4Bd/QAE4NpiczzZvNwAYdSA
        CPp11YGb0aiMdAQOD/no0or3IZ14ouGX8cFTXB6rrSKrnA8WBks3dQM0yYMRMGnpI8tx2U
        gLzqD1QJv37GPvpOAmjbE37eWDze8O0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-GcYU7kXzOpqIrMq2QCJ-ZA-1; Mon, 31 Jan 2022 18:21:44 -0500
X-MC-Unique: GcYU7kXzOpqIrMq2QCJ-ZA-1
Received: by mail-wr1-f72.google.com with SMTP id b3-20020a5d4b83000000b001d676462248so5334090wrt.17
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jan 2022 15:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PrT+G3tPg9tF+5XuIAQ32IRnOTQfqMCqOg72JDwqGHg=;
        b=FkY0V+huQHwM4Ucy+RBKo+zDbLlYvKHGn9bLyKny6bZjScBee7MgX7GOHDRiR06QUy
         PUmBNKpRULxIvmzJZEVNeP7yLEfaLTzTN4M/2RDZRjyKxXb54EquX33H3XoSQRTp2Odl
         +8naCoaL9I38KkeYtHcCjlXbBv+67zVm9FO7I/FHl6Rv5YYsHQkbYEoaX6VBfn4ZKp3A
         0V35oKAe2KFEgqYnvYzdVZwM87AwrKL+wKOxOVTAUlx615WJjsZZOqYXyNfKU9TrO2Oo
         9ncOsMnB8TgBSv/bagAbNAvynOqDRmYhWdICFECY+wHeDTFEb4K+QJYJXIui4BrRrnaS
         uXCQ==
X-Gm-Message-State: AOAM532BpRcV0zAn3PAfzWsEfBHDzzX+BbCIvdIVwK3UGVUFjVRJz5+d
        WMefqmGFv4rGiO8/p0GFpNcvNzLYgp0/Rhq3B6UxSh+topxwMX1dGkhznFAPfI0mUX/hNXovk8/
        JFsQwI0FpmkJSP1X3eDlV
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr28332789wmi.46.1643671303290;
        Mon, 31 Jan 2022 15:21:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+5Kta65CM2LqtBZ8N7f7NRu724ZDFebRcaJ9B9wuQH3sMcUBfk67n6fa4xazee4fo9ruHBg==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr28332767wmi.46.1643671303032;
        Mon, 31 Jan 2022 15:21:43 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p3sm515814wmq.40.2022.01.31.15.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 15:21:42 -0800 (PST)
Message-ID: <c7818782-ab41-b526-9e81-e769259baa52@redhat.com>
Date:   Tue, 1 Feb 2022 00:21:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
 <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Simon,

Thanks for your feedback.

On 1/31/22 21:39, Simon Ser wrote:
> On Monday, January 31st, 2022 at 21:36, Simon Ser <contact@emersion.fr> wrote:
> 
>> This driver only advertises XRGB8888 in ssd1307_formats. It would be nice to
>> expose R8 as well so that user-space can directly produce suitable buffers.
>> It would also be nice to have some kind of preferred format, so that user-space
>> knows R8 is preferred over XRGB8888.
> 
> Hm, since the format used by the hw is actually R1, adding that to drm_fourcc.h
> would be even better.
> 

Yes, agreed that would be nice. We discussed this already with Thomas and my
suggestion was to land the driver as is, advertising XRGB8888. Which is also
what the other driver using monochrome does (drivers/gpu/drm/tiny/repaper.c):

https://www.spinics.net/lists/dri-devel/msg331328.html

As a follow-up we can wire up al the needed bits to have a DRM/KMS driver that
could expose a R1 format.

> Let me know if you want me to type up any of the user-space bits.
> 

Thanks! I also could help to add the needed support in the user-space stack.

Best reagards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

