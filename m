Return-Path: <linux-pwm+bounces-2310-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032D8D6878
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B3F1F23929
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182817C7CD;
	Fri, 31 May 2024 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V40jc/UK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168F1DFCB;
	Fri, 31 May 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177852; cv=none; b=JPrw0+LncEPLtzGpakUrRw9iSQtdkkA5L8l5cJbrVXc6RdVzIj2fNEK+Tveu3svUVRT9LKV6u1EDnitdHVsu7GTwo8tlL8anLzGtByfEE0ZBs3CngdFybYX9IJrFtNAFiYflWnpDR/1KdQAkjC23t5mimQ0nKPxpmFGGyf/g8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177852; c=relaxed/simple;
	bh=Atau1URvHwfFT5T7PHKE6HiDVTXw/ms+8/vtB9x/KUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6vBRTwyndUT5JDZh3xabpBZzxoS9xBruMbQ0uHt0stQAFcDGRjJFEdY3KzqvTiCXQJfZujeGzsEVHz8BX8V2E4YCrKHnkvtG90TOhxW1nqk0FLqnZ1U7ZoPwxnpyzVfPYvtlTZu9d6pzpCUfYBECLLcEYYCo/6BlyNBzJ6JMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V40jc/UK; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-df7722171bcso2293018276.3;
        Fri, 31 May 2024 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717177850; x=1717782650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Atau1URvHwfFT5T7PHKE6HiDVTXw/ms+8/vtB9x/KUk=;
        b=V40jc/UKtLJ2RDuZV8l0A3TVM3Q7LpX1f5uSaHlZAL5KAiv0Tv7rQpXreSQCd94Cka
         JIU0xVqTyQAnjIQU8G2WYrecsxSe1uKbpzU7u3VRjiZydlkJxpfA1kLbQaga3o3D/x8+
         XMVirN16ok0OJdhMyPa4MEuXVd2OO0bp+TqLCvTjvFVy3M/dm5YT3wfbrddJpxBpN7Al
         Ub659gBOFCe3FDMA8Q4+BqIIYhaTXU5TwJNoL1/KqrAG2SkgPReczLJJl7ogV7qcCFdy
         d2y6o77zE1euCWjpnoeSXWTM8Il33KHXveDlSRCmCjthfwUSMWlHnufV03d9BLjrmTGd
         jqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717177850; x=1717782650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Atau1URvHwfFT5T7PHKE6HiDVTXw/ms+8/vtB9x/KUk=;
        b=nnz2RPYreXabMlUynkbjpX83jS9Vjj04bdYMHhpwiXimzIgJsDbN8rZdJlTn8s+IZy
         KCRHl8uvGbmnUQWfpBUdrYo6K+q7QI3KtHNcv7/qhmuu2Qh23tBIHsulMcGtRO2V9fsF
         dFGb0XvCV6qW+8rLbVgptrFHAuX0UMTG4wg7uhqCDmXHvmVAi6EO2E8t+oOLoRcm0wGQ
         TjKG04Rg3jdd+towfBjX9Fbbs8m8kCwJHguQMUxDL+IIsG2o5fPGhuZjJ6qHqtzlIyQW
         rPRbXSbzxwvWc8mQUqKIPSzOruZ1jmYf2wfdTtMXcbrJuNLBMgOY1bGOEdqMMq+IKiVn
         +KJg==
X-Forwarded-Encrypted: i=1; AJvYcCXwFwy5fvDyMSvrKVxOhv/7fJ7E4V0PeF0fYt4srMNyy0RbYi8odChqYZdwVgNVIF45VIjhJLIkYft8XVG4sHFRmJEh2sDXnE2G59Ajv7abIuo5EIdIr0rOhhY5IIufGm2W+vB3xQ==
X-Gm-Message-State: AOJu0YygogWtt8+bkdV1Vx98ADZbt1HkhBYuHcdUdDSGnRof/upjC18w
	vP4jHa8QDJYLqyYbhVBDZXfKI3pyfaY/Zz25d0u7qguAiUnj0IQ/MFd9kkAm3hPSWKxwchuRqZE
	yveUQ1xEiqkNcM4jB70tx+1S7sLk=
X-Google-Smtp-Source: AGHT+IGfpgVBtSJVjCqXGnH8H64qsE/dutU25hN1mvv7gHBogYjfdAizPMz6GykYygm4KbQ5mpPzr4sUablf1PT9yKU=
X-Received: by 2002:a25:e0cf:0:b0:dfa:4adc:e91c with SMTP id
 3f1490d57ef6-dfa73db1bc5mr2847810276.48.1717177849523; Fri, 31 May 2024
 10:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531141152.327592-1-kikuchan98@gmail.com> <20240531141152.327592-4-kikuchan98@gmail.com>
 <18d98f83-aeee-4022-b418-ed6e81988d27@kernel.org>
In-Reply-To: <18d98f83-aeee-4022-b418-ed6e81988d27@kernel.org>
From: Hironori KIKUCHI <kikuchan98@gmail.com>
Date: Sat, 1 Jun 2024 02:50:37 +0900
Message-ID: <CAG40kxE-gwJ3O5LWb5FfQm5UwFGgdvNgQoeNRJTZHi-uT92pOQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: pwm: sun20i: Add compatible string for
 Allwinner H616 PWM
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Aleksandr Shubin <privatesub2@gmail.com>, 
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Krzysztof,
Thank you for your reply.

> There is no such file and there is no dependency (lore link) neither
> here nor in cover letter.

I'm so sorry, it's based on the patch series:
https://lore.kernel.org/linux-sunxi/20240520184227.120956-1-privatesub2@gmail.com/T/#u

Best regards,
kikuchan.

