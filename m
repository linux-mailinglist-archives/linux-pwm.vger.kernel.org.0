Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B6186105
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 01:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgCPAzo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 15 Mar 2020 20:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbgCPAzo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 15 Mar 2020 20:55:44 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91FE9205C9;
        Mon, 16 Mar 2020 00:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584320143;
        bh=+ZZ/y8SuDPR9RUlD1SdC6DFv29xVsKJc0ztY2BqK6UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KPD1rDHRbhj4YN5AwKbZ3QYJ0DhDLi6iTPkSKEGpUeCZQlX8YSUipODkzMjEn7LKx
         7Ru1qbUy+O5wo4bNFNnt2kkkIdWfmldkBDGqRGT7PfslQikKOHz9t+o4OQ4lLFCdW0
         KQ4cVQ+1vQYrRFJHi3tC05+KUmsC7yLndeqyxBE8=
Date:   Mon, 16 Mar 2020 08:55:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Paul Barker <pbarker@konsulko.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dts: imx6: Allow flags argument in pwms reference
Message-ID: <20200316005536.GF17221@dragon>
References: <20200309145558.16098-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309145558.16098-1-pbarker@konsulko.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 09, 2020 at 02:55:58PM +0000, Paul Barker wrote:
> The pwm-imx27 driver supports a third argument in a pwms reference to
> provide flags. However #pwm-cells needs to be set to <3> in the pwm node
> so that these flags can be passed through to the driver. Once #pwm-cells
> is <3>, all pwms references need to use the 3-cell form.
> 
> Signed-off-by: Paul Barker <pbarker@konsulko.com>

'ARM: dts: imx6: ...' to be prefix please.

Shawn
