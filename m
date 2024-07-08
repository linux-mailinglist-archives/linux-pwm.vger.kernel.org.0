Return-Path: <linux-pwm+bounces-2730-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C322392A676
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 17:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C2A1C20880
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8A4146003;
	Mon,  8 Jul 2024 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWpyd+WJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4AB145A01;
	Mon,  8 Jul 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454072; cv=none; b=IpnB6o7IFjpr8BUS40NqX0/PIqOgQPlyntlPuzgfOCrZ/mc5747FDdcrZlEgD6eHlKTEJYMH2h8mq1dMSJQW36BTMUKATbbGMk+TG0h3pzq4PXV059qwxxMjSPLoTk4vWjU64Fe075IKBjp4YiLSFGpBGHs2/TRON2QYisjsdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454072; c=relaxed/simple;
	bh=TrC9tl/J8IWK07HqC0Jtxhbm3VnByPog6tc9bj27EIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7wEpEPJMGdcqUJZfmo4u9XZHkQgTp2B1oI5Kyu7jp4T5kvhLB7kEqWyaHd9hTRA2ets1bUlX63pi+afPWr2+eCSNM3k6iJsy+2VvU0ZsIHd6573utL6uB1wIEgikFJYTl+1DUIiwnx5MeAPCeExAUDZer3f+zk6dy++h4iGEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWpyd+WJ; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-810177d1760so1293087241.2;
        Mon, 08 Jul 2024 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720454069; x=1721058869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jA0wRlSERdOUIy/qi57GffPjw/ZRlZpxkgmsgkKytY=;
        b=GWpyd+WJly4QUzCEGbz3X2t7plZbhggDCNRPbS4VFXha03z0P2jzihULbUd26Jslwr
         CTMzqnXEW3dOYNQY334FIfvzL0pfJ2FkK2q6NEV5HjdBguS8pmykDhzhJDF0Q+HjvUBw
         UDIzz1zQf3YLwRax4F3sRShF3oy2w6emndJMbO3FTBjLTNEJI9YadSIp8WNQvpjq9Yli
         DwUKSIDzig0HSd63l4Ru5rW7ryS7cn4REfrQTNjydSKtMMIJeebBLBOcKyDggd7YMD03
         6zHzr+yal7Hd6gg6QXPhvPgg7sTLRWZ3+1eD+0D9WMpLJwPQWeE8C7HUYhVKgB1PPzOc
         3u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454069; x=1721058869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jA0wRlSERdOUIy/qi57GffPjw/ZRlZpxkgmsgkKytY=;
        b=ZfIPn3qjqZ3BttO63JrOaYo+qIKq9GhxYZuzTVuJZG+KqS0P/5A1YgwrvTCSWmWMME
         GcEStq+Mzs8asyNGYaCK3B4mR9yt9hWndGywDJLzjic/hjvmMbpqYE5OFnro27lggvCK
         7/0EItkrF3jnrV0O22vpSWb/7nNN0RPVMY1U+UEu0I8bxGTUoV8s+dEe385XNLRGPMAa
         NBtQC9bejRuMgkHxlZag72GAkflyytH6t6AWQu0Cusvrgkb71m5sNmFgmE5MHkPmO0DP
         7ME9x+15eOHg1Bpcu7AfrqRfevvvrgg1YxsrHLTqCNWygQQcg6Q6FIOepAb5JEwvIeqH
         I/6g==
X-Forwarded-Encrypted: i=1; AJvYcCXCHotjeM4tNX0u89KI9PiREfoGzbwsEv9lBI+M//90++TZO+QOh5c42iv9jadcGqH0gb9zkkq3wt7i3oIKJkq7PAMnNbpFY+g57UtSRFqXy7Eig1gOmHDEM+LX35MI6AWL2OSHpUdlr+N8TSig4WsS9Y+kiUK/s8MOcEmcIIczVBPgVjf9b3eGchncvfU0f6jjz1Dnxyrwbgwwg4VO9ngw8s3xVr9a6BUNEV0o6vkeUw/2+GmvDF+res7H+h8wQ1Ah+01ql0DW68Acfogv48B7B8YuTthFGleVOWWm4ylsOmipT+tatpQFIy6/dPaVWhXUYtEIXUNntqNPOLFxjxC3iMT+dE82fx7ouEscJePK6fGAWtpL1gZIpXzQO55AKiXe4qRaC/SLPwtDv7qRUtasYiKpaq0RQ85U7q3MMdrq2XkEl4x6Ii3X+I1LmuuF1dE=
X-Gm-Message-State: AOJu0YywDrsVU/7FUPnOCt6b4gzyXPg6rAiHjIlrEXCht9iVZ8I9SwF9
	glL7W5vxJ56R82scCtZ56FD/Ue4emt8S+uf06VJyXQYy/BuDzE5LTuTeIw+1hWV4VOfResmiTG1
	86/auE7SfXofThq6z0Ej80jHGpGWE6lKB
X-Google-Smtp-Source: AGHT+IEZBoFU3ZLzG609wCmA5rnXqDuMLd0d2n5SrJ2I0lXatTkHpvsta1P7z0S7Pi2hNjQpBbhQnvIV2JNr2DTMmOU=
X-Received: by 2002:a67:e302:0:b0:48f:eabd:d72a with SMTP id
 ada2fe7eead31-48fee8a4cb2mr13105031137.17.1720454069449; Mon, 08 Jul 2024
 08:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-23-e3f6662017ac@gmail.com> <13fea5c0-5906-4075-b734-52649e35eb69@linaro.org>
In-Reply-To: <13fea5c0-5906-4075-b734-52649e35eb69@linaro.org>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 8 Jul 2024 18:54:18 +0300
Message-ID: <CABTCjFDebBxf=XcvTbVtifROFHrQLXtArLtj0wHVF_e529NVAg@mail.gmail.com>
Subject: Re: [PATCH v3 23/23] arm64: dts: qcom: starqltechn: add new features
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 18 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 17:12, Kon=
rad Dybcio <konrad.dybcio@linaro.org>:
>
>
...
>
> >       gpio-reserved-ranges =3D <0 4>, <27 4>, <81 4>, <85 4>;
>
> Do you know what these are for?
>
> Konrad

<85 4> is spi for fingerprint.
<27 4> is spi for eSE(embedded Secure Element)
The rest shouldn't be reserved.

--=20

Best regards,
Dzmitry

