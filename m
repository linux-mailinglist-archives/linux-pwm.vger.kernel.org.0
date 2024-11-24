Return-Path: <linux-pwm+bounces-4137-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEED9D77BE
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 20:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C58B23053
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 17:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1AB5103F;
	Sun, 24 Nov 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbUHdLe2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42B2500C9;
	Sun, 24 Nov 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469136; cv=none; b=Jd0qc/60ICC4xzxhj2nVeGLTtTLAqSw4zqEjUzdgPv6O2Khjzg6GuVrNv9VaDdsk/WXDcf4zIi56SHsK+PTGsw5KZpUD+TudAlxLTbxtplv95reQAXe9W/momVox43Wf22LasmqVJSclRFV6GQt6rZnnhTHUmur8iLkJXYE/vAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469136; c=relaxed/simple;
	bh=xkei7SKy+BXPhBFtJI/2hNIGqfprq9wKmCc3yQUOQVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0gPGiBHHDJIThQlSBa2zgmUVbey/OefXoI1iSGAQO4y9eD7zcLofmYujE3YwBtZLSjsEFEXw09F4Je75O3LPczDv7ClaR+XSgk1xOV8M6pTUV+IljKJwktCIk8eB7PuJqkJNzdyBqWwthGmQgzQUz4hg0NZloxvz65xLRiqtF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbUHdLe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4D8C4CECC;
	Sun, 24 Nov 2024 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732469136;
	bh=xkei7SKy+BXPhBFtJI/2hNIGqfprq9wKmCc3yQUOQVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JbUHdLe2t/Qdkla74X0llcVD8LwO8+tFERZupxVexjETVdBFpKpFmmwPyNFpeacci
	 Agj7tfYyVmjLrREeJVT5us0S7tvy34fY05St/uuJU56hgcc/ACB8LFUE4NpBuPnlan
	 +zWw5/oMMdlGT2wFoV0DS34EhSqJo8cYROo+vi/IKltxwqDzFAujH+dhN06yttXn8d
	 /1zsVo9icsVkhKp06s6xYByZH8FKi2vxd48/Ikt+rTxEVkIfmMemjj8/o5hiYYGhBP
	 O+yUDkOEg/Zx5Zz3xJVmiAyrKJl0BmCri2IgJPmUzn+/7UM6Mzuz/iRgftk6Bq6Iqg
	 8ADu15L3rtiPw==
Date: Sun, 24 Nov 2024 17:25:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 13/16] doc: iio: ad7944: describe offload support
Message-ID: <20241124172527.08ef8705@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-13-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-13-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:52 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add a section to the ad7944 documentation describing how to use the
> driver with SPI offloading.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

