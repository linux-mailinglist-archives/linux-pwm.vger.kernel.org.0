Return-Path: <linux-pwm+bounces-3510-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36C099283C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 11:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC4B283CA0
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 09:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3498B18E37D;
	Mon,  7 Oct 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rX6f/0U8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58518F2F2;
	Mon,  7 Oct 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293691; cv=none; b=SRxA3ghkioz2pO3YwnRfef+JBMnVAkhcJHBxQIEMAiLqXmhNcnZhxhehMDvtzHHrqYWjGZJKpwza+LHmYNxIp5Ck8l54Z5w4jzhhfDYFc3rJKhckS+/PAbmPeRgPx7x7kZWdbMCUrBeA5mA+IGoabPjugtgOlItmUQ641hW1r20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293691; c=relaxed/simple;
	bh=E8AFC3vJAjHzrpqVDLoldFXTK/U5srUyH05spTlfP1w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DXo1jy6UyKFZd9jp0/mHEP8X2MzgISUkqzqC7mSxmzIsqir9zIIdAKkN+21sM6NuFcedhmqUrquD5nHrw3nc8Ft3x/LhGcWjfs43z1sMus6bs6fc2Oqv+tchgtMMeOYxH6r3Mt1pfvw4xp4FBt4PugkpcME6rNCusEYT6N/bIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rX6f/0U8; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728293655; x=1728898455; i=markus.elfring@web.de;
	bh=E8AFC3vJAjHzrpqVDLoldFXTK/U5srUyH05spTlfP1w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rX6f/0U8f5wtmtxWrZmbLaBUzcCAsjuUakwZA9Nvdf+pYNhTqKiWDWaMbcmxHtcG
	 RbqoXJbP18hyUwpsjJRBud/wwf8s0HyUSpJQUV7969GxZ2iE1gu5tZCw2laj+ujog
	 Ubp7/87d5tzGMRSC1ZGAfyitE15IJ2LvIP1Zp2mkzcOslqyfClNfJUgI9+b2fOF+v
	 la03gsOvjqbT8HqO4gfrb9Z4MEE8RZ54s3cYDnxvBiuoaWNvUtwP8KVUoRxDOIZGX
	 6j9TCohZ0BeinzHxpKoCdgjNhKPe2bxJ/ejeVL4zENE3QbJOHzhjKZUOghjMIeuln
	 PYOYJao80vNRTzLg+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4fI-1t89CX08ja-009AV3; Mon, 07
 Oct 2024 11:34:15 +0200
Message-ID: <4e1d50de-8e00-47a3-94e0-5ee9c5df8755@web.de>
Date: Mon, 7 Oct 2024 11:34:13 +0200
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
References: <20241007013036.3104877-1-lanzano.alex@gmail.com>
Subject: Re: [PATCH v9 0/2] Add driver for Sharp Memory LCD
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241007013036.3104877-1-lanzano.alex@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rR2t7Wp2hZRiAb/yvZ9QgARwGiDDwzquxtShZ89SpcJPiec4qQB
 6bLSocXYLUlNWmFEpjB+t2lsProJxaVXkFnIipZELFqgz03WEDRwcu1awSTO12RQb+2JDDR
 G2lyvui1h9Aih3uiJWr5lvTsPH8ak29feabOGUhquhqKWumeIFsXU6nrgzhXqiM7EoXi9eL
 GkhHbba2YZyjdjkyhI4hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:teEmP1NgyxY=;NTXvpEe1d0ucl3ou6FBsiGiNXEM
 wfsWbKpcr/5esT4j1RcosJawt4OhCv676VkbSL7veI4uf4d3pKD8MSoxBv2MWwllsySiNXX0V
 9tmBU5+lBm9fMKuvyUzGYsKjbYfY7I1i53ZjApx15089wDAHt8h6dibZzMSZh7TY3ZBLZdMrF
 UDXvpbdRGRt4zZB8rPFiFTxSyRtSiY8L5WB5/Y4uoHAr4jVRmW73DFmOBvVRjpQyFluoxPDhM
 co26t19Sv02s7P+rxWsFjlg9gyvsYmx33xN1zDwKwfA6O7+F3aWXo7XUcabebPhZXx9d8puee
 D5vD02NcecHtuFYFYC1EXGq2/1iVSTwkTU9Au5XdED6uv5KzzXmgNRWpuuIMt7WDXxZp7qL91
 qmlnNhpEugaGfYWNw8ILX96oRE+zFzaGjJEh2rwoyUwkHfmFWvc8QKbVZmpYLNqTwlK1fVpQr
 jn2n45ECm/LkwtAGDALqzBtdPaSCrCu1LFScy2XplHWBSEr9hepadI9KzF49sfLa+pS6ngxuE
 djEX34HmG6HtFjnG4VK5CTAqyS9bKKzNvO2jfmrvTHGI9GewXtwPMbqMJIpThwqGGsBwyRB0l
 46JtYDEkKssML1SBO78zbf+kkUOUDDba5giFfH3hCs6hgGymmSrkq3HjWKP/tKLvalm9c1/t4
 9mj8xM6XJLj0CcM/JZ1blQQBRoeDsGWIEv4mIefNro1JA2x8zSGpzM44htdWUfoDzcC+zS/Yv
 sNtDJrGTJKv/QhTjDezjU33hcNo4NbpAD2g1iFjihwcXJazA25bn8dpeLLq5k9uyvAiJI8H04
 YfFYOSzAMdKjrVLQkgfva+3Q==

> This patch series add support for the monochrome Sharp Memory LCD panels=
.
=E2=80=A6
> ---
> Changes in v9:
=E2=80=A6

Would you like to benefit from the application of scope-based resource man=
agement
(also for this software component)?

Regards,
Markus

