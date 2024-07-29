Return-Path: <linux-pwm+bounces-2931-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF8493FD88
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 20:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D824C1F23028
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 18:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC5A188CC7;
	Mon, 29 Jul 2024 18:39:20 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182B188CB6;
	Mon, 29 Jul 2024 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278360; cv=none; b=OcX1p3YU/uv2W9OUiJex60He3WbOLvpUyx0FsW6EsDTpecrbs7fuR7BXplvFBNM1sXnUttE2BCtBvpFeI6pl8i3cICXn/qQotCC3GZIOrG3N3DCgMaAoqfgIt6VYhTNvoL9KtGHr6BSsRazLwlwD073RM0AU4jYw/5fu8yVCkkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278360; c=relaxed/simple;
	bh=hxCz66SL9VcGksGk7Jvi6bwAvcLd3m/v4tQixT+kSms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUftLxX/HNEiH0+q35oZaIDwj4TqP2sLQ1vjz4nGnYSpcJVy1NEG6NMzmx2iCMxjdTkBUu1f/pIw6R8m8UD/zjyEOnk8kPhgvb7ClewwMByMkabgZiwnBS1u+TtSDGsxCp8a7Bb/A1jbn3aHX4lvQX94qleGSExGLO+0ITtq2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-654cf0a069eso21528607b3.1;
        Mon, 29 Jul 2024 11:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278356; x=1722883156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOI4yfbpADJqWSZhJu/9HLSO4bdHPa7Kukgm+hQ434A=;
        b=AWzV0FT5EfTCQs+Ai8e2jbhmUx2QQoBDfCQOdAtTZhByQM6mrIG0L6RwWsCoFrqhKT
         h+dw6R5vqdtwjRqQyU6r1UVQ+7iICakpDmm40rFGV7Ksg31FpbWUpa2EDLQVKPdwM5Ga
         UJYn1ie8PPGcndSoZNnNETLhazL1mgSVRqXjOjhW9oAcgL073J1MK/cmSkEDL6oDNHB7
         gm/ovGIpOkCsyEFYvdLGLS9NCVOHf/NLUnDM1azWANUhTss5rqX57GWrDXYK5WBSwB5K
         CdXL6gHs5famPygIzRXrch9jFVAOwI4kPfX6XhZtG2wGguKR8VmOE0MDOgpavhskHyz2
         hTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa6quLLGXucyG+DjJlBCtyBcg/svj6GeMMfnbgB8ZScbWOEL8IFXZVg68gs4v23SliYeTQT4m1GbHbylhCjSb1pv6BIMBTdxZ9kZ0Cd3dsAI07FnOJVgPkr9v/+6ZAJuZ2NQaYwg5SkKernb0hbg7Q5dkfHGR4dFLGgvoKED158tB6+w==
X-Gm-Message-State: AOJu0YxenwFkFG67yv0Kr+qzTElERNeY7xp3DKel+uKu2O0OAaQuh1VY
	OjKBB7QtIaXzAJSNndHg9SfuKtE0r3QIdMZtjVgmR3o8quolg0brRWgWg7cI
X-Google-Smtp-Source: AGHT+IGRiM4RFoc2IQAzSRd6DiVm/pIQwD119Qcotql3xYCN8RRicX8T0Z9+K+C1+n1L2kyQ4PdXag==
X-Received: by 2002:a81:9406:0:b0:617:c578:332c with SMTP id 00721157ae682-67a057b8318mr98703667b3.4.1722278355933;
        Mon, 29 Jul 2024 11:39:15 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd90fesm21505217b3.20.2024.07.29.11.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 11:39:15 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65fdfd7b3deso23431797b3.0;
        Mon, 29 Jul 2024 11:39:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1mz8yVfBlmyE2Nm5OiuoPyGWiQ33gT1gxFGLlD8FElWuw37xBJOr0K1Tucxc+0KQDv97zASqPOmWdaGqbbN+aC1i0EQA4W6+GfzA0Jbboq/EAyJfCliUbY+ko8DEwWYunz/6Ene+USjRbQs02bCurtVzNTiIkfoxaAaEO5BvFkp0w9Q==
X-Received: by 2002:a0d:f4c7:0:b0:65f:c95f:e7c7 with SMTP id
 00721157ae682-67a057b830dmr97041367b3.7.1722278354050; Mon, 29 Jul 2024
 11:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725193803.14130-4-wsa+renesas@sang-engineering.com> <20240725193803.14130-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240725193803.14130-5-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jul 2024 20:39:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbHk3H+LgLrzB4zMCPhbN8EhV_EyF_Gwd4eDXY-MKC4A@mail.gmail.com>
Message-ID: <CAMuHMdUbHk3H+LgLrzB4zMCPhbN8EhV_EyF_Gwd4eDXY-MKC4A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: renesas,pwm-rcar: Add r8a779h0 support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 9:38=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Document support for the PWM timers in the Renesas R-Car V4M (R8A779H0)
> SoC.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

