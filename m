Return-Path: <linux-pwm+bounces-8427-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLA2LhPyymkkBQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8427-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 23:58:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6D5361ADF
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 23:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFF46301FAB8
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 21:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD5A3A7590;
	Mon, 30 Mar 2026 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rN4a+tcN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BEA375AAC
	for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907920; cv=pass; b=qCbMzcvXKGjvwllGJ3IrEY+UD6KD7r937XLzNJbdcGRwRlkVJT2ESJT2m1WInWmj+jA72UPLU/EIJPQgLbSWQREAf3faUfc/dWpn5y4vhoAn3Ow42BMRzK/fPEufuC/84ZXslUd8JY8kM45oUIoq/iRV5LUekn5LseIklxLzz1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907920; c=relaxed/simple;
	bh=FJE8Ztq2yR97Wm+KeZdBFg3MTQmh8UlZm5qTyN3YQu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EK8qcw+7pcs6OvUgicWL1AcpjjWv7DvTz/J8vcrVq+ggxDE4gy5WnT/2poLJJbGFM3oEPMZ+EZLaYffgAIG9bQTXHKidcyQPa3+b9MqxVysgomlti+XDwluDWZ0ceimfS3dIs7ZZAaeeo3ScruT6g3a0zhZGVft8fgqGR5YKv/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=rN4a+tcN; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b23f90f53aso27520365ad.0
        for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 14:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774907917; cv=none;
        d=google.com; s=arc-20240605;
        b=fd7yjHIyQ7F9x92BjfeyP5BqmshbNyxt/Rr7PgnVTSAfrak8aXo8dOoZ/c/6VymSU+
         pc+pQk1hGVXhy6IkHlfQDSNMbldk/aDR9hDZZsf/bQ0uF365DQFS+iToxEPBfIOVPqKj
         0Djck5Xcx2cX+Re5ULZGivxn6EM6n/BeiW+L/+taXvbKkj8oUCaMW1DiU1zliL2pL0s2
         59XRPHSYYTtXr3a/O4e0m5oAdUrEXZGhw8EMo/Cs7bAK3MxZEGt+ApnWrcQ1B/+c93c+
         a5JS3x9QS0/krRxvJC/FteFk57IW+i8zTlSMpYX1/mNryhqordhJ1G2ywwbQc+H6qHp9
         89cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FJE8Ztq2yR97Wm+KeZdBFg3MTQmh8UlZm5qTyN3YQu0=;
        fh=0zxe9pzUw7+zM2XXi1XHB97PuslueQTsrKqfLj34de4=;
        b=YdAMN2V5yPBvFoHsXodKBtJc3WyC6EyQ/uVk2kXGw8GifnshxfJjdSWNmTWD0k3sFP
         F/sWq0cuOoCiAgqCCuVkkrfGoY+egXbqQILlZemgWtnNuYW4sRqH+vwESxvuevbU7fYZ
         VzJy3+W7wDqZNmrK+9igXndpDR8vazEOv9TlVNKSkNqjssOnZ+zWVZoeW7kgAv46dj+5
         AWMgEhiAroMmG2AywaXZLhdFTqmtM38DxQ6zQ9f866bgPmRKj5LoQMn5MkXnw+jV2xPb
         qrknyzHcNg9oNrY/F240gZYrNb2SjE3IOR2ErK5O6y9X8P+xCrY97CmtOeXz2yrMcmfe
         ziVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774907917; x=1775512717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJE8Ztq2yR97Wm+KeZdBFg3MTQmh8UlZm5qTyN3YQu0=;
        b=rN4a+tcNQUOeBJZSd5LF6RJXJ4fgX4SDROS2G9zkSVx7E/KCh4/TXkoidPckf6I0EY
         W5keqH8R/JDCIwOlsiwNOfu+AGLjBdN+3Nlg07JG9pLYVxGU1DTlGkm2xKAaH1hOQhiH
         8bbDTfwhqdUti9VUYXrzQN04vin7Ekaby3Dn//M+fnDTZF9YGGn22isnnEq8w6LqxF9W
         BBJiT4d8Gdd2SmItSf03g34El6/yRlbeFWIu9iuuZp2Gn7N+idyVvk7gZb7sLWsxDnkw
         Y53hvh2YwG8AaGd1BlhmWvVrzgEtePk8pRUpvvzN80P4lF6nAz2gjDRP5nCPsMWWEzu7
         k0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907917; x=1775512717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJE8Ztq2yR97Wm+KeZdBFg3MTQmh8UlZm5qTyN3YQu0=;
        b=YSyHIKD+1HvUs0FIAT5KxrKC2H/Aw125I1wcQVsl/a1vbGikdhy7yL0bMu9HXLJlT3
         nePAkV6cRbQYAshhQVx6Peh3+yn/iTm3p7o4E8lnqEMPSpGaxVBkpkeuiPvJY837CtiV
         BbnQ7v+RaCHYzsHPTPy99NIo9WSQku3/PGpv9CiWyHwIFeTqTU4xRkGA4XbBHyMmq8nD
         kRe+87VVaLKbp8yZ685nE76ofUtO40VyHVIgGuy+owD1LXEXQXU8RUkrMcYqe6DuYirs
         a80tkjODVrwOYfPvaa0j86lRDThWsntEB6Nl/Dyt3GxDx+Ji11zUUN9MSH/bnKOqZw3T
         v3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXITWpzTTJoYH22McHLV5MiWnF3pCmaG/iO8Zzp+sYe1qMRM/5rAcFP00re2Fuyw6ckYRDMQDWMkYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uvcaKJNiHJezehCZPuyJBHeEIP4ZQNelvjNaBtYmdWgYrKkJ
	ti2rsnu2l4j9w+ZmcoAq5bduFubryEKoi8JkfAuaQgOyj7OMf81Kh3U47QP0YCwpHdUvJYnecnb
	awM1JywKhGDfMq8MVtVLs1bzrLaj1mrc=
X-Gm-Gg: ATEYQzzcLbkdxxtof/Te0mAwWlcUXafbOrj2w9GY9eurpHW7fequbt5D1tFE4rOuEjV
	2TNyC9XLvOCjMNdHQc8nMNZeAWHB4Y1cmLi1HDLiOPqSqveVHjYJSHn+lcWuTmVJVwKqF15n/oO
	kKk1B4LKAGEfGRLTKIfKgYKTZa8PmDmiP+Z+z/0A6fFDSoWQ10BzFxnwC6nflhQ3OK54iARoP0r
	8jYmxaA9vZRua/n/HbeqgXuGcNWxBwTd2u1sXui69uiBaq6Ig62lKTdYX0LBoLBaINuf0Bw5XoN
	F8gIMuCvEAny31jiOkd1AReZ6uLtshqmEsbroSDuLdwL9Mbvv2w=
X-Received: by 2002:a17:902:ef44:b0:2b2:58c7:2cd6 with SMTP id
 d9443c01a7336-2b258c73377mr34992175ad.5.1774907917613; Mon, 30 Mar 2026
 14:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com> <20260326-s6-s7-pwm-v1-1-67e2f72b98bc@amlogic.com>
In-Reply-To: <20260326-s6-s7-pwm-v1-1-67e2f72b98bc@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 30 Mar 2026 23:58:26 +0200
X-Gm-Features: AQROBzC9sJkgJfCVL7Eb0aOMXTr94-EjxC4gSLY0i2t4mSqOPphK9W4gxOQsQKg
Message-ID: <CAFBinCDOd_Xp3DqqFNDUEfJPq0U=f9FazNAh_=k2B2eOcUeu+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: amlogic: Add new bindings for S6 S7 S7D
To: xianwei.zhao@amlogic.com
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	Junyi Zhao <junyi.zhao@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8427-lists,linux-pwm=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martinblumenstingl@gmail.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,vger.kernel.org,lists.infradead.org,amlogic.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EB6D5361ADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 7:35=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Junyi Zhao <junyi.zhao@amlogic.com>
>
> Amlogic S7/S7D/S6 different from the previous SoCs, a controller
> includes one pwm, at the same time, the controller has only one
> input clock source.
>
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
With the two suggestions from Krzysztof added:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

