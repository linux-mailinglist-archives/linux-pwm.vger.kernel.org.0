Return-Path: <linux-pwm+bounces-1557-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EBB85B723
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 10:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E61F25D80
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD635FDA2;
	Tue, 20 Feb 2024 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I757u9NP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62415F872
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420716; cv=none; b=BedHTBbKX4ms1JVL500dNhpqrMpHhJoQc7L3KNBVg2Xgg8ZzEm++HVn7SS5UmKZEYzEUHPxDnau2Bonfs8vpUF358o9FrYIII7uaIwGP6MgTcGCWFJnpfYEdWWfE0uVaufJeI2aj8QNIwCBarWpq9NjkoCRgfeu7a3rTE61x5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420716; c=relaxed/simple;
	bh=Pjpym6pBWsftiIYC3BXDjxDftaIjTZrVIrPNdDqVV+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fWsmP6AzXUyOnDh2q598QUjN+lGS4TP9ECwRYv33OpPjWroxecchDTlkTTHk3eShMXJn6JTfp4SlpXEMzWpgeVFm+MeH5FKyRPiebVd8VwsTqnxhYdFvetI1DVc/kbcnM/Mm5oetlsGXe5a84FDJiFue6lWfIk3qHgWF3sebW90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I757u9NP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708420713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vkzby9wfQQhUZRcpTbjHhp7P8uZMSLkRfL4T/QvrGZM=;
	b=I757u9NPDxflkfbi7LhzFmOEU22xmVigzsc1OL2jk0GP8Kb9l2PBofZGBox22hydTP6gDg
	7KeNQC/gU1Kl637Jb/2fBJJGwN6yfAKrXONJxdi9WNS51zRFo6JN/b7Np/sUlMN9h01gvY
	nTpgkHiLocNHk6u+C2GJ0ONuIdxDYJo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-LZSO-I2HOsa9JaT-o6Xe1Q-1; Tue, 20 Feb 2024 04:18:30 -0500
X-MC-Unique: LZSO-I2HOsa9JaT-o6Xe1Q-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5119f6dca82so4760028e87.0
        for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 01:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420709; x=1709025509;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkzby9wfQQhUZRcpTbjHhp7P8uZMSLkRfL4T/QvrGZM=;
        b=t8bXkWNEYMBXMuIw7UwZwFQ17H40l6+6li7L7yNDZOv8D64S20/T+kGvfiNroCgPsT
         b/5ii4A3AZefhMr2pvfA7Ubj9xozALUCopZmVEu067GIfBsYrRMMFfMW4bgb8hhdplyD
         8DH2WsCsExjaZlhSFs2Ngb7+NDKy8ICtGmAgXVzdXIRWAPIDW1Qepfp1AjPV8dR9lXd0
         l2w96j3ji73bx1j7ZoH/4yIHNzR0SGTpDpEryZP/tslEd2DzBrYoNb5GJ2SvUL9tCqSR
         xjh7Op6diIC5jiah5FQDGa2/HsCH91MekfRkgDQDJuuiLyFQfiTCS61g/KajzLpgcnpk
         mBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeK2KqART0DJlWPOwZvrgPOjdgOWQJ8Nf0grBkWknunsU9n1wPKKQx+KDPT4DBflxfG8ZE0yuWXehnJiwG2Is/JjgaJu5aSEU2
X-Gm-Message-State: AOJu0Yzwj6TAvSI9trQpRMS/WdgCNbj/9wnj/9Zp22pq6UuKeB6Az2hq
	RVgveMTd0T8SHavmrjUQbyDl5jITkm4Xc3R1G3lsfyBd82Q+wmt5CiQy52PXEnZ7tJPUj/Mc6yM
	uSPTwJSdhaHVtMskxQhEQ19ksSqhIUCEEzw0kr4m3k7J9WZvjZVcej5UcCw==
X-Received: by 2002:a05:6512:159:b0:512:a93a:f5a1 with SMTP id m25-20020a056512015900b00512a93af5a1mr4334352lfo.36.1708420708951;
        Tue, 20 Feb 2024 01:18:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEEqm11cyvxMjF1g+2iM0xRpkZ3M4fWTa6V4c4a2kufWdQQu89dk7xHknoOQDeqxrJBoK9pA==
X-Received: by 2002:a05:6512:159:b0:512:a93a:f5a1 with SMTP id m25-20020a056512015900b00512a93af5a1mr4334341lfo.36.1708420708638;
        Tue, 20 Feb 2024 01:18:28 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0041266f5b041sm5575587wmn.34.2024.02.20.01.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:18:28 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Robin van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH 02/10] auxdisplay/ht16k33: Remove struct
 backlight_ops.check_fb
In-Reply-To: <20240212162645.5661-3-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-3-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:18:27 +0100
Message-ID: <878r3fjxy4.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver sets struct fb_info.bl_dev to the correct backlight
> device. Thus rely on the backlight core code to match backlight
> and framebuffer devices, and remove the extra check_fb function
> from struct backlight_ops.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Robin van der Gracht <robin@protonic.nl>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


