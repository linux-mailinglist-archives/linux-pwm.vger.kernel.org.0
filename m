Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C45F8EE3
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Oct 2022 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiJIVPd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 9 Oct 2022 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiJIVPK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Oct 2022 17:15:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9289526579;
        Sun,  9 Oct 2022 14:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DAE060C4F;
        Sun,  9 Oct 2022 21:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA687C433D6;
        Sun,  9 Oct 2022 21:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665350031;
        bh=2zd6Qg+FP1qIWZIo7NmtEz9KTIyCcblY+UYIslYBvfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K09B9Aqc4zfaC0UAKoCnxPc3j9brP9boX8kCaNZm4Cxei/13BSQug9h/LjmKnmjk2
         NEn4xjl6bDcQez18TFtiKnf1kmJcpH3fkM4EdB6Gm1QSqwi3CGwGYdwP8uVo0mB9pp
         yCtnW70x7y9w4bEk8Da3hl6GLxqNaq2+lhZqcqWhCueM7i30Xxaw1QHS0AwcUr4kH7
         hlblckzTnkZE7OsudTIV81mofDbXK0JrUFP0fWXRR85wmt4Iv6Zkm6yrj5hy5huY8X
         wfiT+ai3DKpU8Af2vBX5tQmBOFisfv+YxB+tTMGpaV1UAR2N1gCunEiIpMtxDEm/wN
         O0OZaDrdVmCBQ==
Date:   Sun, 9 Oct 2022 23:13:47 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: renesas,tpu: Add r8a779g0 support
Message-ID: <Y0M5i6/zl+g8pyur@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <f5ad691051f69f2dbfcb5c5a722960bd9cd41b06.1665156364.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/VB7UW1WsaPGGdk0"
Content-Disposition: inline
In-Reply-To: <f5ad691051f69f2dbfcb5c5a722960bd9cd41b06.1665156364.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/VB7UW1WsaPGGdk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2022 at 05:26:37PM +0200, Geert Uytterhoeven wrote:
> Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
> R-Car V4H (R8A779G0) SoC.
>=20
> Based on a patch in the BSP by CongDang.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--/VB7UW1WsaPGGdk0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNDOYsACgkQFA3kzBSg
Kbbpow/9F+VDJrUOjWjKujGUHXDG83F/sEnme6Yleu+1XrxWOTtDFeC+6V6Unrhf
VcLLc8+XizJG74y1cKRNrP1MKHEuIsPQYMzhFjLB96mUjFIsoOqIluQsU+Y7plt4
nEFctU5WTJ/0OsnQzsaDXeTpstdNOmU51EraZ7rsMuNfvsxFkOoXrJA7XcfNsoGf
TCK3oQ3NA5h2XxG4ChjLbQwbWglo70qyJpMY2HubmU/cl5D/p1dbzPC4Wvm1xW+Q
tsScWa01Sjukr4QaGcQfcoiv/lmVoePEodfC/cW5pIhU3J9C6fHPIrsgN6ufPURl
E2LRseU6U74lQRDgx136wu1m/MPtTO/MRLB5GN3XkyUrl3bzQVplERvYEaCyYemj
vbSMqevvaLsap9NmPw/EWGF2+jhbouuJlhcq5CYGJJ6NfF09pRSx29NgpPuOcBYT
AxRvH65XcJMfU1sGechBLWwaiN5k+Wo6VFr7JTngs1Zz40KNhuECX3yagvCIn2Bp
PU+jWJ46rXnuaiMvJAWLA8/tkvXcPSmj1xpU3kFv72PoIUObMlp3/Flppxh2C+b6
BkHkeQyMZZGtCq50qDzHJ5x+OAjAi1Gbs1czcC2VSnmnD+nJQY2XussH2CHupZ0u
QOBjPIqeweJYNYqKj6d7DhWIN/DsZW+N/NrVXd2xnZSDt8wNNP0=
=3nqH
-----END PGP SIGNATURE-----

--/VB7UW1WsaPGGdk0--
