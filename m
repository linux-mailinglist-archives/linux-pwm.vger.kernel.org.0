Return-Path: <linux-pwm+bounces-3429-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA04A98CF52
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 10:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8801C2239E
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8980D197A95;
	Wed,  2 Oct 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="m6VzFZ0y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641E195FE3;
	Wed,  2 Oct 2024 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859447; cv=none; b=XJaGOLLJn+j6rFWxHqbDzf5sMF6AHuaffXqEXTSiiCIQKdG4tX4oPbMUsrW/KAZcSJiyAvcI4byun7MIJNAR4JdVx4/E6bPs+HqYyQOzhOQrCHwbTkhpzUovzQ+C3xlm4vgDKSk1s3hvboaq4VD4sh4/wvW/ErzzLbND5DwozQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859447; c=relaxed/simple;
	bh=ulMyylkHSMIpkflrRuTjpsi9ymfR21Y31b+clxaonpk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rloqX3mRPxppQ16LO8G1aDlgDCy8HoOMgelCUKyG1sRVh0xYQiQ3bNVSudoAhiGKfLH5yWyegsgWC+rAk/CYo/GYYs3xg6N7MxWqv4SvlBTj8dz7L+fMJonoUDDJIHa9fXvh53fN0XUKJViZInSKmuVNpcP/88IoExpnTU+yosY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=m6VzFZ0y; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727859410; x=1728464210; i=markus.elfring@web.de;
	bh=bS8/Xo3kRqtJJnblPciGzaxgOW4xTAy+DHMyFQruVtM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m6VzFZ0yBUDS1oCExgnIui3IEtH7mkn99HbiFEK7ylIvyGriIQ5hoIYYurbVgltt
	 2PFKL/Nq05L2SgfbSRNsPrYlrlcumaK+c96DbVNSeSDJ5utsPaeol4Nb8FS+doCDC
	 uDpqxOL7cJ3k6niYTS+DwaUZdFMESs4wyX2rWGRxnIbGr04EM/Xg3OXuM3bxtEY3u
	 Cn7XGa/uIzf7BxgPo3v/zIh9LSGKs4HCXRkOjX70os3MRB+K6snBJTuog1+Sqt4Ar
	 wYDHQ4VpgrWNcglp+LZGFa0fYkPccK2ehfbe4LKdNumH/MAl9DEFhLZcRkfsO/mV3
	 0zKLwksD0Ya1pG8RUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1sYdeB3FsT-00P6Px; Wed, 02
 Oct 2024 10:56:50 +0200
Message-ID: <b671e4d2-e969-4b9a-a7ff-b3b688689ee8@web.de>
Date: Wed, 2 Oct 2024 10:56:42 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alex Lanzano <lanzano.alex@gmail.com>,
 Mehdi Djait <mehdi.djait@bootlin.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Shuah Khan <skhan@linuxfoundation.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20241002033807.682177-3-lanzano.alex@gmail.com>
Subject: Re: [PATCH v8 2/2] drm/tiny: Add driver for Sharp Memory LCD
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241002033807.682177-3-lanzano.alex@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vhLcqF0l3a1X0tEXBQvzRNAEyzfq1m372/WAvOxH0gS0gZSBK2O
 tCsVmgDAgiOZiw5OetbQvcOa/+cbIK+Q+iyCim8FwFNTx4ta//XJhV9D6TF9RGzQhRHGVWV
 u4r5aD03tsvkq2VkZhjTPcdc1Tsqvj9uV0SPbxruvh+Qm1zFt/J0vtOf+W1rzHriomrGGPN
 wpdniAA0lVwzDGSlBDmWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2NpKZLPepfU=;OSLZD+gSJ/tWmd3PAiHH6gnDnQX
 liX5Mc6vboAfHQGI6OOGMV/ZNas2zszXWEcONymMRa35Aq8zw3V5VMfwe09BKWIb/QJ1HT2zo
 5BI/Q/gwr0G3Efzm0QpAvdGpbqim5crQHFDrMVGM4S44p5fjr/EgrVT6ll9XumlQfN3oqMi4R
 nYYj0Z6Ifv4FPwtmK+nuBHcSZ157LypZsj0dLX67lT1sMt327Of+OHtHtR9IuNAo4GWTSEEG4
 TIVfTONS/oQBnnGVWhw8MQoPlMwN5bqLbBDGA1l7ZWr28g23ThYpkJCv0heW4KlzSHQZ1ZNGF
 kIr3xvI68pvaCDXhn7WH9GvC77oBcuIIfwQ7k1lKhyxV8fV/cAqiH9xeHKOu5hbKmP68/paRL
 ZL9xVrg8d7IALPIMM70AKERLl66PiY6fDK3FZIyJjG7hcl5pH/jr5bLQYKSzZBO68wF1onFCK
 opIHE4U41wWA3DBp03wcRiR+MZzCD24I97lMH/V1yK3MG7g6rYllkI0IdCmKzjkFysukJwVPx
 CJGrKjfRzQlpJv+PWqYBM3Y16tnaKU7epCKI3YQFRxphWDRF/YNP0ICc84git46f6Zz2rWOUE
 E9s9/gMqoqZvnIZP81wZClKpW9F6z+TCjr2Wy/zrJmb+NuJ0RX5DNQ+djBrs21kCIN7dwwgK4
 zsi/hRlzHmqqTE75ZC7A1NfxVit5fPh7IAp2p4LSkE9ym7GIwa/1LninDNWYSTgaQPMXzs0E3
 kY5hBEF8Ky7YyJa4OE9+eJgjF4ZSRzjKUy74hPVkVEuWpo8xjmoxyYdfySNstt3dUGhZ8uEEK
 zsf+6I1O8TWUXYceHOdiJcWQ==

=E2=80=A6
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> @@ -0,0 +1,681 @@
=E2=80=A6
> +static int sharp_memory_maintain_display(struct sharp_memory_device *sm=
d)
> +{
=E2=80=A6
> +	u8 *tx_buffer =3D smd->tx_buffer;
> +
> +	mutex_lock(&smd->tx_mutex);
=E2=80=A6
> +	mutex_unlock(&smd->tx_mutex);
> +
> +	return ret;
> +}
=E2=80=A6

Will development interests grow for the application of a statement
like =E2=80=9Cguard(mutex)(&smd->tx_mutex);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.12-rc1/source/include/linux/mutex.h#L2=
01

Regards,
Markus

