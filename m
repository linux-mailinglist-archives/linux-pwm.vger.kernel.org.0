Return-Path: <linux-pwm+bounces-1559-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE7F85B73F
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 10:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB371C23EDD
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125C53E15;
	Tue, 20 Feb 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfOgC1db"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F25F480
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421095; cv=none; b=qI9YmTSXMbPx1J0Mkvcw2sCCGY3vNfCxTeOzHnBp/MfSkAYCnzU1jugnQ12zuCbcGL+Vegv0TawCB1OULNCNAOQH/Zdizyoe9Kk7/mPBDBdhX0Ilk9BSkujr4EQQkHXnWX0pTnCu9Rprea3mLXXDVQpuSVcX89Z5hESQyqQuMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421095; c=relaxed/simple;
	bh=udKLWycwu+hf+6x5oFlyNQr/LkDvsWZpDbgX4ydJdKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DEiF6UJgcHBHw/8eAcy2TCPkAnJ6t9qKzRR7Y3Wm2hvoeF0yFy0FB4zP+jLGwj2yjZ1IJhHlJwuRXLjL/Mpa7fD7Pc4QloIX/mJCK4pYB+nIW2feRK+jEy2BBXO27iisFkUf82EbX9S6Tjdgc8lS3qafwtfdFV2NiM3gm0iCT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfOgC1db; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xshxlpsQluS7qRAd7fMDdSOWA/KW0tH/DDlQJBA+rDs=;
	b=LfOgC1db1K56AHho9mtA2Iu4ukPRa2JNkgGVuSdurkqFtR/6vUhlGWe+Fe/OlhmbFsW7GR
	btNFIlf9QOrOsRW9vePM1V0EhhFbgydoq9mafvKa5z0DN1l0VimewPLI1wwZrsLZCS78JL
	7eNIamfMEWQy06CfTeYv7tJMjFaOZ2c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-gFb2vJRtNkCyvKnRJCvdrA-1; Tue, 20 Feb 2024 04:24:51 -0500
X-MC-Unique: gFb2vJRtNkCyvKnRJCvdrA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-411ac839dc5so28718325e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 01:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421090; x=1709025890;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xshxlpsQluS7qRAd7fMDdSOWA/KW0tH/DDlQJBA+rDs=;
        b=WRQfHtXegvmsZhqRlar4N71WZaB7zoqLJshGp3X/e+UUuJ2WlDLw2/0C0ENS6okBet
         OxitiKKw5ruhbBnnntwrFseTK9hyAy22SsC2/nAaN2+WFzs+uvxE8bF4xGvbCrJ+n1Y3
         VAEsA2ZIVYB0uiSyW5ec5YSqflKzH2zY9GmPipYjYALLpO0dI0LR1ThQ6nkKby9VqFb5
         xI6A3qjqfJcxAeZgdYUAxvUA0Kza1di5TfikFH03W7eVhklFqzl/Hp0AVTIoEeFxDjBV
         ib63VkDZcJ7coiloU1qLFgrLsrNfdbAV1MyulWwgUyVVT25Hx8ut4cQut+wMkNt7QtNj
         gSHg==
X-Forwarded-Encrypted: i=1; AJvYcCWlxhrbzju7giEjN2d0Hb0yitSstHdLqQavG6pD8+AZg0msuScCl6H13p5WO87I+xvjhPkEc8GbCm0KVJzWASx/Y2DXtsG9fZ1d
X-Gm-Message-State: AOJu0YxTIOYEtxLp1IxFGzt+Dp0J5MCwg2YjZT/Ll+1865pdrnlBak2D
	CGbYkc5aW8SXGwJTfyWiX16U5ERJC/c7d5kD8B4Gdc9BOEyLWxupvILbWnXZO/kDL+NVNa3Q4TG
	dAa4JUUt/WWzgSpqr6d1qgWlJemg4rEtE76LG8oCRrfjsf0+l44ciZ54ITg==
X-Received: by 2002:a05:600c:1d26:b0:40f:de6a:2a27 with SMTP id l38-20020a05600c1d2600b0040fde6a2a27mr7454593wms.40.1708421090415;
        Tue, 20 Feb 2024 01:24:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkPjh10xOQRjnJMuYej9HPk/BhMMWKcIszDd75k/eW3ji67ZhUwGUtMHTKJ5oYHxYrfH7Zng==
X-Received: by 2002:a05:600c:1d26:b0:40f:de6a:2a27 with SMTP id l38-20020a05600c1d2600b0040fde6a2a27mr7454582wms.40.1708421090135;
        Tue, 20 Feb 2024 01:24:50 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b00412704a0e4asm779017wma.2.2024.02.20.01.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:24:49 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Bruno =?utf-8?Q?Pr=C3=A9mont?=
 <bonbons@linux-vserver.org>
Subject: Re: [PATCH 04/10] hid/hid-picolcd: Remove struct
 backlight_ops.check_fb
In-Reply-To: <20240212162645.5661-5-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-5-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:24:49 +0100
Message-ID: <8734tnjxni.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver sets struct fb_info.bl_dev to the correct backlight
> device. Thus rely on the backlight core code to match backlight
> and framebuffer devices, and remove the extra check_fb function
> from struct backlight_ops.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
> ---

[...]

> +#ifdef CONFIG_HID_PICOLCD_BACKLIGHT
> +	info->bl_dev =3D data->backlight;
> +#endif
> +

The robot complains about this, I think that you also need to guard
against CONFIG_FB_BACKLIGHT being defined. Alternatively, you could
include a preparatory patch to fix the HID_PICOLCD_BACKLIGHT config
symbol dependencies.

Other than that,

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


