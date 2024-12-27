Return-Path: <linux-pwm+bounces-4520-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC569FD187
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 08:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DDD3A066E
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 07:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94E14D717;
	Fri, 27 Dec 2024 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMZoBBxN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C2149C6A;
	Fri, 27 Dec 2024 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735285344; cv=none; b=rspPj1rJQiAxds1ou/KTlAyMDiG9Zo7prNQKtazkpn749PVcPEpE0pPmW/05VFc4Gb8gOwlooqy1TMOjjbAEBK96sI560qKt3gyXe303sNOZlFhJh9G27FwvupyLNK/l42hUbIQ0B3jxdBWLToOuf+ip7kTWobs97LOhSHjJ5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735285344; c=relaxed/simple;
	bh=gWGtyTFJgaJffoNbyeoot1oowobuuGFBuEE706eXXAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhIuyPgwCRcY19OJ/cRjNCOSFTwMZlHMqfUry6bmq67ZX3tRfcFmOe5uuN8wW9iGi59W3gRE3w0W3V+asAuJd23tKfhutEYz7SlOmkguvWnTwVDkpjmkXsNrnnaK5cs9w9QYXKiVMppaQPTMB+OJkHyfe7tbAl87D9Xa1mtkUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMZoBBxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F12C4CED0;
	Fri, 27 Dec 2024 07:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735285344;
	bh=gWGtyTFJgaJffoNbyeoot1oowobuuGFBuEE706eXXAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMZoBBxNRZ0HOYa16X5nrRft1gmuBLRNSQgDrV8mr48hlue8N4A48mECoBrQ6KqBj
	 cSOJwgelgfq6mTKLp3qsdvDeMOfPsIahlt8Kq4SuM1h+QzBaIYkT+/zJst9gsaj6KL
	 RxhaEIvh9VR/4xCFmD76gyFYjnTzxNKKx2Rd/RLWwDcYl53SVfOAj3wHGSxQgh67+Z
	 T89Rbc0BTNLGXmSFKJQYIGzVrNaLf6kxVUHtbqjXpvIQ2RfHFsrWJu0C5DhR4fpfiC
	 2Mbib+jRsaJ3YVrfekxhzc9Z20Lxu9h3KCvFNA5y3h/u0DdEHuvPg+G8rPezsk1Ys+
	 LgJypTgfPDK5A==
Date: Fri, 27 Dec 2024 08:42:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, heiko@sntech.de, 
	linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/17] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
Message-ID: <xq67rd3a6yeie3kajdnzufbxctqxmv2h3ufhqauoqmxe3hk2oa@vnru4lmtpkm3>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-12-kever.yang@rock-chips.com>
 <qvr7x4anlxxtpxjywrqjihxyxejw4i73wrh2ibl3hasayew4s2@obyuxce4ez4g>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <qvr7x4anlxxtpxjywrqjihxyxejw4i73wrh2ibl3hasayew4s2@obyuxce4ez4g>

On Fri, Dec 27, 2024 at 08:24:15AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Dec 24, 2024 at 05:49:14PM +0800, Kever Yang wrote:
> > Add rockchip,rk3562-pwm compatible string.
> >=20
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>=20
> What is your merge plan here? From my POV merging the pwm update via my
> pwm tree would be the easiest. But if you want to let it go via (say)


No clue, but we already provided feedback this is supposed to be split
per subsystem. Not much improved.

Best regards,
Krzysztof


