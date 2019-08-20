Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB1495707
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 07:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfHTF6Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 01:58:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37335 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTF6Z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Aug 2019 01:58:25 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzx9s-0004CX-OO; Tue, 20 Aug 2019 07:58:16 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hzx9s-0001zV-44; Tue, 20 Aug 2019 07:58:16 +0200
Date:   Tue, 20 Aug 2019 07:58:16 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 6/10] dt-bindings: pwm: update bindings for MT7628 SoC
Message-ID: <20190820055816.nbjah54rzdx72vp5@pengutronix.de>
References: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
 <1566265225-27452-7-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566265225-27452-7-git-send-email-sam.shih@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 20, 2019 at 09:40:21AM +0800, Sam Shih wrote:
> From: sam shih <sam.shih@mediatek.com>
> 
> This updates bindings for MT7628 pwm controller.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>

Apart from different capitalisation in Author name and S-o-B, this patch
looks fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
