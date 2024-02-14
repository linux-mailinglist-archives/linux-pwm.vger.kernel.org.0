Return-Path: <linux-pwm+bounces-1505-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42588551F0
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 19:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA1F1C2172F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 18:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854361272CD;
	Wed, 14 Feb 2024 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPTzm7p2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6B126F3E
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934723; cv=none; b=A6H2to40RjEEY1Z0BYSzfuQzfuocoOTr9OsSGUrOExvOb9US/iIS21jqYi9qj+Ys7DsuBDBbzIomYsnhRBuTYjayUN5MRnLS9k+RMAM/OUuB6oQqkZkYjMoQxTJHvNCllEIZJx5FWseNw0B/55jbHsMV2C02wz0TAxoPzdYmFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934723; c=relaxed/simple;
	bh=pdWO+CmZ1j2/eSrGPMC6+oRqlqPXczDz0PW1JXUoMRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/Im5/lNRtIXnNLp1co7xCVLkWig12zZiYSOMMN+c96kNli/FAgl4uiSF+0LDWqxN/h8uMNS9NAeFSNLUnpYj8mD6vnJCiwRgSBa8lLLBAw2oQjblvKFqJvwkPSvaCHwkLifIiL7yAr7UwKcsMWvVsLw0Av6xtjjBgIaPJGjiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPTzm7p2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783f27300b1so1631885a.1
        for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 10:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707934721; x=1708539521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdWO+CmZ1j2/eSrGPMC6+oRqlqPXczDz0PW1JXUoMRo=;
        b=GPTzm7p2LQNn1Hvn003LpcoDSm1bKPn9uoCpA5JpZeGwQKYJ8lehDgOxLAIawl53vu
         MOl6/Ok/GnwGjm/CaUPnOli7WBYTae5aaMglZwy/mmqpPe/iqzIuP2jgE6LcqBAcPX/C
         B49JrAmK7hoZyk8F2NAys4Gd7p/sOliYQJgSXQpSgKCw9NYZyj0jhAVYJcj/9DYfL9sj
         k3wnLyNQ/zJaIl8JALKjbEl0HiWK4c1bizAUxJYp1Zbk7zDEbRpb7wxsQz1r4sMEBh0q
         mRjJgKJKlUkQqRTh/ZjWehF/9OGrBEHkQNwCmnMHwgP3mj/Bg7PlDS8r9x8soWOq4SsS
         PGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707934721; x=1708539521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdWO+CmZ1j2/eSrGPMC6+oRqlqPXczDz0PW1JXUoMRo=;
        b=AKmhWVWwVPnb8WYNqfQZ/XTp8axqRx5j4Qsjbl30bVXCPYVlJb+FYzqUV/fdw5T6re
         ETFZDbKsaIE0K800Z/vKhLsYeY+WBZnJFoUpnBDHOLRPc0a8UUzzj7sUt0ACpn0PJ1vB
         ku6F5QbCRyynSywoGopakIOEBeszFU04ZBC4nllBoMop+fHftXMg1a8L6kDWe+C01NGO
         FpnyIUWzvSaRswG1kxL2UvyzTg6n7LfaPz5rhUgAR2R0UUqAJMeyCOGCgpiO+QXHD2X7
         RUPXyeXGCcTMVpHJYyDmGWKRxhRJ/hhb+dJGQo0srtIa04gqI/O3684J2A4Lez8A+YKy
         /0AA==
X-Forwarded-Encrypted: i=1; AJvYcCXwqwi1vq2pMh3nXxQXLyhpMKQ0AYfXC+DHZbqQ1OmNUBkBBl2YDEyShiDcy9QRxhVpd+Jm+TsIBkEzMdl3qvI+0LROa1HWUZ2l
X-Gm-Message-State: AOJu0YyCEzEm/HuQWUjjDBcgrgeMTdpJk4Z3GkNijqLXleckYSI2ouri
	5Jp2tmcRsQg6EsAjt6IIRQlWy/eKNoB2X9J9i2oCd8WT+2HG3Ckz
X-Google-Smtp-Source: AGHT+IFPOifeqiTAKueo/mPQwNX8+tB2SU886FJ86e3Ue+GP1GJcJ64cVLv0KRisjLdMfi9T0cQk8Q==
X-Received: by 2002:a05:6214:d44:b0:68c:a4a8:b134 with SMTP id 4-20020a0562140d4400b0068ca4a8b134mr3968400qvr.45.1707934720783;
        Wed, 14 Feb 2024 10:18:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTntyE0vHjRQZqbkrkqEtijdJbZh43+GlE7PqzdzftutAkh1BswvRA+WmtqZtXU5BUyBuq6lZxMA0/fmVwBzJ+i3nrpwVsh3bFtEVNHbk1NpC48NtcI/1JcNHqIIV0WL54zog6TJ5L7KR/12g+Pg5YxMwa4/Z0VVbopI7BwSSHgRm/n/wZCRDPEad+le8GxT1hk070JJSlbgiz2FKaMssRSVMyAOmsokae99cuPQwT7jJA
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id lb7-20020a056214318700b0068c88a31f1bsm942636qvb.89.2024.02.14.10.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:18:40 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 linux-pwm@vger.kernel.org,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 kernel@pengutronix.de
Subject:
 Re: [PATCH v6 125/164] pwm: sun4i: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 19:18:37 +0100
Message-ID: <6016472.lOV4Wx5bFT@jernej-laptop>
In-Reply-To:
 <f8e3fb96fe341ba0a4bed982aa731c5c7c355b83.1707900770.git.u.kleine-koenig@pengutronix.de>
References:
 <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <f8e3fb96fe341ba0a4bed982aa731c5c7c355b83.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne sreda, 14. februar 2024 ob 10:32:52 CET je Uwe Kleine-K=F6nig napisal(a=
):
> This prepares the driver for further changes that will drop struct
> pwm_chip chip from struct sun4i_pwm_chip. Use the pwm_chip as driver
> data instead of the sun4i_pwm_chip to get access to the pwm_chip in
> sun4i_pwm_remove() without using sun4ichip->chip.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



