Return-Path: <linux-pwm+bounces-1561-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5295285B752
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 10:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9CC1F25E9E
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA23605C1;
	Tue, 20 Feb 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFROOUWE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1E5FDBF
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421233; cv=none; b=Mw3u3ibV8AcU8jTk0PezKN8VVZeKIIsTvbX/7dm/r03hb0PxnnslOK9R9TA6wE5khSYzpwk+LERF3SEtHRK1czqWco5hUoc3k5bPo4m/c1bxCdy2rtUwTvBsl8C4weKwBALb+3cT2zbAvT43idANt7rFJhYYg15NFq7dDcHIYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421233; c=relaxed/simple;
	bh=Cr049JDQLVE6h9YwU+hPc42YZw3O5KaA0156euo/6HU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jr2NHT0RC5ELqE7cL5RcY0G+wM3WNvfhk2fGK3ZNjzbRunfSQ7eHweVE7/xU5vlFDshkTEWZ61aeR47OhlyM50K1bOIHQZVCPQeLq/DMTQ4twAsiZzN4HOpm6AwBWatAvleJWE6nAl9tracUqYMULbSysElrxGsJzCQraYgH9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFROOUWE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cr049JDQLVE6h9YwU+hPc42YZw3O5KaA0156euo/6HU=;
	b=jFROOUWEIOprRmqYt/pSA6T7eCfWQS5o4cI0FsSPIaXSBwASyBHxH+K1WioXBsTU7Uz6Ec
	db8TZVHRLXmdD9O4zW2+QJB4uMNgWHymwqxGjOWVM5ikY3pZ4s+I98gbvvPqoFiSDMR00f
	xVy1bxReVGha2jsdDnL5yPFatJKn1us=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-2lN5NgxIOgOktADBNmeaEQ-1; Tue, 20 Feb 2024 04:27:09 -0500
X-MC-Unique: 2lN5NgxIOgOktADBNmeaEQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d2399a08c0so13897181fa.3
        for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 01:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421228; x=1709026028;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr049JDQLVE6h9YwU+hPc42YZw3O5KaA0156euo/6HU=;
        b=O+oEKf6SqUiyEuXnk7o3gxjryhieoa1J90+dLecAK3sBwxeweh9hJ8PYTLKXmbL2Hm
         /EF/YF+6XbiGB9jaHeYz9wwGH+eg4v8CaRf4ijp+Oqm1AE85i7zmcNXSoukn4GQkYqIJ
         IGVBW6ZdRqVuUELzaEsnEZ/qQ6Kg9ZwbazRWK8aIv/8NdadARFz779+lE0BeJZcr5xfB
         erRQR7LnTQNnjy3fJ4DTKtj1JaunOLiyppKUTTx4zcgn3u38QBbil0cAATZkr+Sth1/2
         738aS8TUCoggk/EOjticyADKY46fI3fRawk4OAc+QUdjr9IFyey2Cal6VEM3klln5gYV
         r3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpfYgRetvvaDOvhdopKVYx1HMXbAXjF/vEJJ8gxWGik7eiPHQe0W9vu7F7AQksMI+kxa/9zNo9jp2ngoPTFqe5Syc41Mlczjg6
X-Gm-Message-State: AOJu0Yw8OWPrKUsA/EMEFd0dz3TSmWX99UXedYv8LxaMMZH3jGZb0mEF
	d3QgYmKT8mEQUUORmLR5pJTYR35weXfzYP42hrbwnM0EJP6doj+kHa6MXfF/CzqxVbVHf/GKBlV
	sfmEpGHWb5vSGJvoaE31siktYUd6t5aDnHc/vQ7GFa5jJUzPjvZdXaAst1g==
X-Received: by 2002:a2e:8895:0:b0:2d2:3707:485c with SMTP id k21-20020a2e8895000000b002d23707485cmr4468707lji.20.1708421227880;
        Tue, 20 Feb 2024 01:27:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIOUqTz15wX4tpCLDU3x6oh41ZPQVlb/WZWHFmGcfp/tIINmvltfgmSrW/DyUZvNLfveew0g==
X-Received: by 2002:a2e:8895:0:b0:2d2:3707:485c with SMTP id k21-20020a2e8895000000b002d23707485cmr4468689lji.20.1708421227590;
        Tue, 20 Feb 2024 01:27:07 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d55cd000000b0033b198efbedsm12732585wrw.15.2024.02.20.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:27:07 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 06/10] backlight/pwm-backlight: Remove struct
 backlight_ops.check_fb
In-Reply-To: <20240212162645.5661-7-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-7-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:27:06 +0100
Message-ID: <87wmqziiz9.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The internal check_fb callback from struct pwm_bl_data is never
> implemented. thus the driver's implementation of check_fb always
> returns true, which is the backlight core's default if no
> implementation has been set. So remove the code from the driver.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


