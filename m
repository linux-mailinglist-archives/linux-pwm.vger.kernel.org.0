Return-Path: <linux-pwm+bounces-4716-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE4EA1A37A
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 12:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88171188B8E3
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33820E333;
	Thu, 23 Jan 2025 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB3vXxYb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78920C016;
	Thu, 23 Jan 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632819; cv=none; b=HMlXcK2Ed+FyoYbKelUHZ+H5569hGQMA4Gw5ILboIqQr9U/SZ1glJtr0P+CvfIymx8rPhD+9yuMrs18y3TWpMszPsIy3lNjtvfFBOvx9CSt2hputBRrusyKdYHWk1DxZ0UUsch8CZVdpEljb8Ng0wgrcKefbIy+x7TnOyG4+oBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632819; c=relaxed/simple;
	bh=BV/UiZ1sneiWLLoz4DLt1p64h6oGm//LvUGgaLTuMqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyIP2QMsbtKPi4q6Uexg7twoMBSuLUYH9tR4oU588KV60hd4vIHXc15T9BpKrwQFEKXv8Afk6ExEu623ngT5vbVUvvGa8E5pFTfISoTljA5dsjNiQp+p1lBSN+dpEkkqwffE+WZhj3XogTn+aiY/Vsh0B6rXgj83uNx8TVkx4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB3vXxYb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso179161166b.3;
        Thu, 23 Jan 2025 03:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737632816; x=1738237616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV/UiZ1sneiWLLoz4DLt1p64h6oGm//LvUGgaLTuMqM=;
        b=OB3vXxYb6Dejsgg3sYmmBKBtTN9wUoiToIcO8FWO1vFXJyt0r42FVQJehgcsCvlo3z
         89XRyNJNHiW3Mv+VcRXDg9emLO04EXHOVNShQ/VzmhFowkH16OuUsmEzcmCx2U/5CYd9
         rZOXpZby4T+Y8aDZm+uyULYL6PHg1DGfKFi/7LdyXnUYRjfV0o2se3E2GFgGXPS7eclL
         jRaS4S8tIc4JytsLhx8oQYmZRBIGo7LHDcRK3c7vgv3hVcOmm7MtSQiZX+v0Dwxn/rGO
         rQHGThXhONrL+LX95JxVUHIfaft9GaKUrIBEIyzTt+JJH5KpswawrZLuc+qDO/Mn7o1v
         RDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632816; x=1738237616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BV/UiZ1sneiWLLoz4DLt1p64h6oGm//LvUGgaLTuMqM=;
        b=vTKM0IMdCVSUvqTet1OLj6bZqljoNK0hJsMXdC8GKCO+ZL3sgc1kKuYmOEnHzd+zKG
         1JbsOwucuDJfN1uiHjdoZshrjcGp5bVAamyEGS5epj8Io+1cO9waF5MxJfeBMkXKvAb9
         MYZ4tWAFL35Avm6EUFjRhrTqgIM34l6USA0bIYCFYT6ttVJlMGrqNfTm7eBi31B5aHOz
         6McB2/KcOiYreCXJ1jRuCK4ung3HmsvYqT+1/2E89hAs52RMz0iMviwK8hjiGgcn61G8
         zPIUU46mFiCVLHNbmXKdp72xu26uqwWpClcPRGajMIFmZDHzl6ta/rSqW+/ncNhGODg5
         IFuw==
X-Forwarded-Encrypted: i=1; AJvYcCWdEl6/nkhUHdb5chMkrslHNeXg0OYgy95VTmaocTb3c7AN0pwxMuYgOdh8YcHniCWTylAd0rJz7QPZ@vger.kernel.org, AJvYcCXNx2IRnHtwI5//o1nTU11yhcOHmSZ9r4i1ebtuT/ExzQC5ZvJgP91IRuVI6hp4EWq0//8SYOxptNjv@vger.kernel.org
X-Gm-Message-State: AOJu0YxxjCW2TcnE8fl6MqOvqNbeayKsOd7yka/KyjsK1v9FkmxcPRmS
	InaHhdiB+kvemLvEuLhqza+IUDxMA/clLrR4i7nDWXzTeIkgae25RJ3NgNmtx1qNZSy+fKzx4Ss
	R+ns2DcuY5mghL1sicnEmNURXmqI=
X-Gm-Gg: ASbGnctaAEBhYa7Z/EksYuix4MVP2nCdPjDTGnK/ZwlbNuwpLO7ZdlHyGb7xbFM44vf
	ipF/uFlS2BqFhRtc4dZ/LP3kzy7mn6YfCV5pm0JeosS6vGCQHWBr6aVZCTrZOPmQY
X-Google-Smtp-Source: AGHT+IGlBGo49b8hq0PUDSHDid+TJzKZqBDMzios58rk5Q40P0L/4Wuu1ezel/WKi4BDXJOKm6HQk6PAjL05l33tdMk=
X-Received: by 2002:a17:907:7fa6:b0:ab3:84b3:9a7c with SMTP id
 a640c23a62f3a-ab38af450f4mr2355305666b.0.1737632816456; Thu, 23 Jan 2025
 03:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 23 Jan 2025 13:46:20 +0200
X-Gm-Features: AbW1kvabjMu6_OPFfUXcwx7VgYMArz7Iqud-CR24uI2T9HXvfkjxw5oYCu6f4pk
Message-ID: <CAHp75VfM==nakJpuPoQp8rK1EbF3fFPpyUxRBYaC3ksafzqngg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pwm: lpss: module namespace fixes
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 12:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> in (implicit) v1[1] I suggested to move the MODULE_IMPORT_NS magic into
> include/linux/platform_data/x86/pwm-lpss.h. While I still consider that
> a good idea I was overruled and so here comes the variant with the
> explicit MODULE_IMPORT_NS in each module that makes use of the
> respective symbols.
>
> I don't have a fixed merge plan for this series (assuming it gets the
> expected Acks). Either way (both via pwm, both via pinctrl or the
> pinctrl patch first and the pwm one in the next cycle) is fine for me.

I can take this via the Intel pin control tree. I only don't like the
ifdeffery in MODULE_*() block.

--=20
With Best Regards,
Andy Shevchenko

