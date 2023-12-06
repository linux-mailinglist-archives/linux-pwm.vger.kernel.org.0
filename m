Return-Path: <linux-pwm+bounces-418-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A01EC807084
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 14:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529991F2132E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E4B3714E;
	Wed,  6 Dec 2023 13:07:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BC41BD
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 05:07:02 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rArcC-0001zB-AL; Wed, 06 Dec 2023 14:07:00 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Thierry Reding <thierry.reding@gmail.com>,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v4 086/115] pwm: rockchip: Make use of devm_pwmchip_alloc()
 function
Date: Wed, 06 Dec 2023 14:06:59 +0100
Message-ID: <2584330.irdbgypaU6@diego>
In-Reply-To:
 <6ff62a16862768b6817819b95e2924e41e05274f.1701860672.git.u.kleine-koenig@pengutronix.de>
References:
 <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
 <6ff62a16862768b6817819b95e2924e41e05274f.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Mittwoch, 6. Dezember 2023, 12:44:40 CET schrieb Uwe Kleine-K=F6nig:
> This prepares the pwm-rockchip driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I looked the important patches up on lore (adding devm_pwmchip_alloc
for example) and the change looks correct, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



