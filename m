Return-Path: <linux-pwm+bounces-3992-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F709B8C1A
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 08:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DF11F2146D
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13FB14F10F;
	Fri,  1 Nov 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmpaSUhs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF055896;
	Fri,  1 Nov 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446472; cv=none; b=imKvVpwAFONz9Uh7zSQFATapA7QaIbAfGz87U7prpS8uAmGq6MtWU5YkC9haqmv+4Tap3cenmP69x4CF9aqzjRDkaqklGIVp0kOoYxCbHgzVJpGrXOVHF49Q43SnzEfzHF0Fnj26iT+HMJWR8nEp2/RpS5Jt6XpxuBxLTab4pQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446472; c=relaxed/simple;
	bh=VGTOFhMBWgnLF/lFvzfcMPafKSuCJHfffgfA9hwPgVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGxW5A1aK7CVzOOHxDRgFf4UioiyaY8sXOaxveSHfWKTypHH+NTgkurRC+2fYf9LRtPx9aLvqR4qe8Nzrq6EeMQjfYYM6RzO91fUppPJDQfsIkhnT9Ik46kBC3iOA7EbA9wpE73QEFzPzMFA2qUOTWT3XJwVjSQmBxPAz7KVJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmpaSUhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4166EC4CECD;
	Fri,  1 Nov 2024 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730446472;
	bh=VGTOFhMBWgnLF/lFvzfcMPafKSuCJHfffgfA9hwPgVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmpaSUhsCZI8TiNgWtKnNq0cp7Ucf6Sbac/ibs5trlbtuUnN3JlryZIXLsP9ioiWP
	 Ki+qoxD/uUDZjMtAwLckGWnYo3alOuts1w5Hr72SJRZnkjRE7tmL1a+jrmp2pAwNf1
	 iC8PHmfGzl0b5a6NQHTdOgIvHC8MNZJInLWr16b8aa8cS2GPVlgN/EAjwm4tIMAK8X
	 Boh2/A4YNr4yFVqcE0lqfcpDTEKcWW5wvBOS/W7EviDFeYUqOZSzIKvQTlPai6Vo40
	 AgiChXsmnZtQg1aPRIjYr8kdHJgkGlx1+itSsoOIu9qLP6yDS7yjrpDQvtTF4efXVg
	 Nim3NcA+YYFlw==
Date: Fri, 1 Nov 2024 08:34:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: marvell,berlin-pwm: Convert from txt
 to yaml
Message-ID: <fxxngvgnlcsucxilxtug3rp2gshogiro34zgv2rpkvpzlc47te@66tf673i5kle>
References: <20241029160837.590199-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241029160837.590199-2-u.kleine-koenig@baylibre.com>

On Tue, Oct 29, 2024 at 05:08:36PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Formalize the binding for marvell,berlin-pwm devices and make them
> automatically checkable. No change to the binding intended.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


