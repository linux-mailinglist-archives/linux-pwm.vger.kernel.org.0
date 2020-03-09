Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D1117E3AF
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 16:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCIPel (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Mar 2020 11:34:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40671 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgCIPek (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Mar 2020 11:34:40 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jBKQR-0007u6-JR; Mon, 09 Mar 2020 16:34:39 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jBKQP-0003op-L5; Mon, 09 Mar 2020 16:34:37 +0100
Date:   Mon, 9 Mar 2020 16:34:37 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Barker <pbarker@konsulko.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] dts: imx6: Allow flags argument in pwms reference
Message-ID: <20200309153437.lwc5uutytj7rvee2@pengutronix.de>
References: <20200309145558.16098-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200309145558.16098-1-pbarker@konsulko.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

while I like the result in general I'd be a bit more careful here. So
I'd split this into several steps:

  a) add
	#pwm-cells = <3>;
     to the soc.dtsi and undo this by adding
	#pwm-cells = <2>;
     to all machine.dts (that don't already have #pwm-cells = <3>)

  b) for each machine with explicit #pwm-cells = <2>; convert to ... =
     <3>;.

This has the advantage that after a) there are no changes to the .dtb
files which can be easily verified. And the patches in b) can be
individually reverted in case something machine specific breaks.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
