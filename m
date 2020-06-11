Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF101F7051
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2020 00:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgFKWfD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 Jun 2020 18:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgFKWfD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 11 Jun 2020 18:35:03 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4762073E;
        Thu, 11 Jun 2020 22:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591914902;
        bh=gwbad36ci73nUilrGtt6jC6dYf8PIdwF48yaLdcVXm8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Od59i5ICuZ4toyiQOI1JXBRQzVaVaND+HwYd3buOOvnvaOaavpq1w51ldk/V8R2Cf
         liE/wpp7P4a2Yjvj/RNO+eC6t30ey6qGpxtlDMLRxY2A7Ipi1KxZ1aA2otP71FZO4i
         TerIPB4Qwd8OZdFbb7fICHsiRbF9mHGTbNxd7nUU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200611194738.1480393-1-robh@kernel.org>
References: <20200611194738.1480393-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Remove redundant 'maxItems'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-clk@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Date:   Thu, 11 Jun 2020 15:35:02 -0700
Message-ID: <159191490219.242598.961023303796459910@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Quoting Rob Herring (2020-06-11 12:47:38)
> There's no need to specify 'maxItems' with the same value as the number
> of entries in 'items'. A meta-schema update will catch future cases.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org> # clk
