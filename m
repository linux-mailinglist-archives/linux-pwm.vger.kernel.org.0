Return-Path: <linux-pwm+bounces-1558-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05485B726
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 10:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EF31F25DEE
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829D760264;
	Tue, 20 Feb 2024 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZMkmLF+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914995FEEA
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420775; cv=none; b=JM7XAU9dRnq788CPEwae+Rk/EqXMh2hOACQFrmvd7WKLa6jkepZWPu8/YcQrnZpZzuECkfG53LzYcR18UAF4P0ygGPL66guoGHBdBZioMZSsKzt2gUSx3aHS5/1mCFZjlwZjiVYA/OgkHsx+y5h4POEDvtuETxHHple2ejTQncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420775; c=relaxed/simple;
	bh=QSKI5DJWNWiQUQy8PSHe+VdPXu7WJOu5tx0cx/gLfpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BW7Xc1KpU2mUfc2eDsZNT/zbpAOhIDQbECVdF0lg9i4a6KQKwx6xKrHEoVZqQ9Cq4ra9MWsx7EarXF1y5F8d3lzFCvPNxsZuvKKYQAUXo0uWbt60aQNzm7hzkrl9fo2a6kEtXPbRRmrmlTlYoM7+KCGp1gwokU9WGXfcBCQo+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZMkmLF+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708420769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSKI5DJWNWiQUQy8PSHe+VdPXu7WJOu5tx0cx/gLfpc=;
	b=GZMkmLF+XXP/JcDRw4m4XKQPkvbOVzQ6RrgRA6dcuVOd6XjUPdy1vEwk4ZoYnZMmwZTn6H
	ydnlnWO62acFeMYwsxC79soUC6wJYD914K+FUigWxA0ZPxfe66mUSlbyoFTxfmxFWjFWQV
	sGi+Rn3ITUje0yNWgnWaTsgIRdHp620=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-Z9Bqtr2NMp2vZjed08U-Ew-1; Tue, 20 Feb 2024 04:19:28 -0500
X-MC-Unique: Z9Bqtr2NMp2vZjed08U-Ew-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d5e12bbbdso658648f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 01:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420767; x=1709025567;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSKI5DJWNWiQUQy8PSHe+VdPXu7WJOu5tx0cx/gLfpc=;
        b=WwY+yNX6seRtl6mDgnftdy9CQTrsjgpZI/mEdGg6i7DaoRcdC2nAAZkcinJOkBngHa
         9oSQmbQh0WW36ZffMAc1uh4lHkJETV/ejDcsLS9hla+mJjPzKhxKXkHhbVIMEz3vLHJ8
         WYKF1qLdIPDgez4eb+YZk7B0ODxp0S1MU13POVsgWJAgxxtHv+o09SqK8ujIYn2yGE2G
         nfuYhd31jLkWiMd6kgz3VPav4i5ZOGG8gks0TiHS3WqbNrw81ZwHZByWaEds9iT7WT1z
         7WXnyyVD4OVhU0f1RBUfe7Yaik4CI319YTlhpP1pshJw9YnThxlu1AVkehkEDqU3gOeA
         Dd+g==
X-Forwarded-Encrypted: i=1; AJvYcCXBMkQkTHL3e409b9NsATHVPR3u0+rmTkYomj4/pmBvIqEe1mRyjwNIn1MXjJWCInpJLbzbYkLpGebj73mCKDJvm3pyBbNbD3LZ
X-Gm-Message-State: AOJu0YwzyxgwWLKzjUIExf3X3S2o9LG0Asld1KOyDRG35dgrHtScfhZm
	riQOgH/SrIrMJLif2L2o1vpdYk0Fp0FnuT8TlmAPEiEiTJ3NC7P3grOfiRi2fZVL4x6xAcNrp6o
	SOVQHlN0FXmX9zcFPwzVLNi0uAuto9SyC9aiYZqoaZvOGXcb0bSvZSc7Iqw==
X-Received: by 2002:a5d:6786:0:b0:33d:211a:7916 with SMTP id v6-20020a5d6786000000b0033d211a7916mr5926222wru.44.1708420766988;
        Tue, 20 Feb 2024 01:19:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTe50tTS4pbmxQYTMjD2j/YAzqOczhi1muOVjjeiUkN0RVGhBVXraWyeGB4LGC9gqQftjerg==
X-Received: by 2002:a5d:6786:0:b0:33d:211a:7916 with SMTP id v6-20020a5d6786000000b0033d211a7916mr5926210wru.44.1708420766657;
        Tue, 20 Feb 2024 01:19:26 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ay3-20020a5d6f03000000b0033d1b760125sm13186512wrb.92.2024.02.20.01.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:19:26 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Bruno =?utf-8?Q?Pr=C3=A9mont?=
 <bonbons@linux-vserver.org>
Subject: Re: [PATCH 03/10] hid/hid-picolcd: Fix initialization order
In-Reply-To: <20240212162645.5661-4-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-4-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:19:25 +0100
Message-ID: <875xyjjxwi.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

> For drivers that support backlight, LCD and fbdev devices, fbdev has
> to be initialized last. See documentation for struct fbinfo.bl_dev.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


