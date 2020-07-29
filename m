Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4B231A49
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 09:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgG2HZF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 03:25:05 -0400
Received: from a27-45.smtp-out.us-west-2.amazonses.com ([54.240.27.45]:34084
        "EHLO a27-45.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgG2HZE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Jul 2020 03:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7jvkchcrhflv7qhbkgrcypyraifp65wy; d=rt.linuxfoundation.org;
        t=1596007503;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding;
        bh=3K0uS6QMEVfmI8Nq4hVkL3/CQMaXTFOquufM/ynNwJY=;
        b=NevgxlLjMbzmZ+u8nofR9qqnJa1npsWdMIwz2K3yI91h3ZnxctAPP/odVDuav9WI
        bRoaD7Bh9VxaZTGBFvdoPQg55vVuaDrHLZotGo1Ss3X2IAhLzpRpx0u/kXHHaG8yz3a
        11E5iGqmqtlKDIq3xK/uWoSHVdbKydypQ5IZLBXY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1596007503;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=3K0uS6QMEVfmI8Nq4hVkL3/CQMaXTFOquufM/ynNwJY=;
        b=MBpdl5/dobwSLdrBGYQ/InsTTf/RDgUsWCt2kXjQoCf8CH6XSVpnrLD8dhoaKhpi
        gbr5QFAzhJuIgPZpx667OPxLbnB7T5MqJhFKW1RrAn85dDBO4Qx87qMkspUUoNQhIMN
        KK+49ALRV0cRopZRQpNhCazeNpCYw3sMEhmZn2dU=
Subject: Re: [Kernel.org Helpdesk #89942] Re: adding linux-pwm archives to lore.kernel.org?
From:   "=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= via RT" 
        <kernel-helpdesk@rt.linuxfoundation.org>
Reply-To: kernel-helpdesk@rt.linuxfoundation.org
In-Reply-To: <20200729072459.c6gwkr224lcbmd7r@pengutronix.de>
References: <RT-Ticket-89942@linuxfoundation>
 <20200213102618.x5j6kfvqmdbx2pr2@pengutronix.de>
 <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
 <0101017398e048cb-4976944a-cc5c-4183-a073-1bf01692ec77-000000@us-west-2.amazonses.com> <20200729072459.c6gwkr224lcbmd7r@pengutronix.de>
Message-ID: <010101739975d2fb-cf472f7e-bf59-44e2-9ac2-df2b18ee7411-000000@us-west-2.amazonses.com>
X-RT-Loop-Prevention: linuxfoundation.org
X-RT-Ticket: linuxfoundation.org #89942
X-Managed-BY: RT 4.4.0 (http://www.bestpractical.com/rt/)
X-RT-Originator: u.kleine-koenig@pengutronix.de
CC:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com
X-RT-Original-Encoding: utf-8
Content-Type: multipart/mixed; boundary="----------=_1596007502-29248-1053"
Date:   Wed, 29 Jul 2020 07:25:02 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.07.29-54.240.27.45
Feedback-ID: 1.us-west-2.3ULHQnc20aILdVzjlbQ8UqO1WRWzA1U01b2uFAcT62w=:AmazonSES
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1596007502-29248-1053
Content-Type: text/plain; charset="utf-8"

Hello Chris,

On Wed, Jul 29, 2020 at 04:41:42AM +0000, Chris Hoy Poy via RT wrote:
> this is currently finishing up importing the archive, but should be otherwise available for use. 
> 
> https://lore.kernel.org/linux-pwm
> 
> apologies for any delays, please let me know if there are any issues!

Great, we even didn't have to collect from our inboxes. Thanks, I look
forward on using this service.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |


------------=_1596007502-29248-1053
Content-Type: application/x-rt-original-message
Content-Disposition: inline
Content-Transfer-Encoding: base64
RT-Attachment: 89942/2052334/1714154

RnJvbSB1a2xAcGVuZ3V0cm9uaXguZGUgIFdlZCBKdWwgMjkgMDc6MjU6MDIg
MjAyMApSZXR1cm4tUGF0aDogPHVrbEBwZW5ndXRyb25peC5kZT4KWC1Pcmln
aW5hbC1Ubzoga2VybmVsLWhlbHBkZXNrQHJ0LmxpbnV4Zm91bmRhdGlvbi5v
cmcKRGVsaXZlcmVkLVRvOiBrZXJuZWwtaGVscGRlc2tAcnQubGludXhmb3Vu
ZGF0aW9uLm9yZwpSZWNlaXZlZDogZnJvbSBtZXRpcy5leHQucGVuZ3V0cm9u
aXguZGUgKG1ldGlzLmV4dC5wZW5ndXRyb25peC5kZSBbODUuMjIwLjE2NS43
MV0pCglieSBhd3MtdXMtd2VzdC0yLWxmaXQtcnQtMS53ZWIuY29kZWF1cm9y
YS5vcmcgKFBvc3RmaXgpIHdpdGggRVNNVFAgaWQgQzhEN0VDMDNBRkYKCWZv
ciA8a2VybmVsLWhlbHBkZXNrQHJ0LmxpbnV4Zm91bmRhdGlvbi5vcmc+OyBX
ZWQsIDI5IEp1bCAyMDIwIDA3OjI1OjAxICswMDAwIChVVEMpClJlY2VpdmVk
OiBmcm9tIHB0eS5oaS5wZW5ndXRyb25peC5kZSAoWzIwMDE6NjdjOjY3MDox
MDA6MWQ6OmM1XSkKCWJ5IG1ldGlzLmV4dC5wZW5ndXRyb25peC5kZSB3aXRo
IGVzbXRwcyAoVExTMS4yOkVDREhFX1JTQV9BRVNfMjU2X0dDTV9TSEEzODQ6
MjU2KQoJKEV4aW0gNC45MikKCShlbnZlbG9wZS1mcm9tIDx1a2xAcGVuZ3V0
cm9uaXguZGU+KQoJaWQgMWswZ1NTLTAwMDQzeC1KQzsgV2VkLCAyOSBKdWwg
MjAyMCAwOToyNTowMCArMDIwMApSZWNlaXZlZDogZnJvbSB1a2wgYnkgcHR5
LmhpLnBlbmd1dHJvbml4LmRlIHdpdGggbG9jYWwgKEV4aW0gNC44OSkKCShl
bnZlbG9wZS1mcm9tIDx1a2xAcGVuZ3V0cm9uaXguZGU+KQoJaWQgMWswZ1NT
LTAwMDQzbi0wRjsgV2VkLCAyOSBKdWwgMjAyMCAwOToyNTowMCArMDIwMApE
YXRlOiBXZWQsIDI5IEp1bCAyMDIwIDA5OjI0OjU5ICswMjAwCkZyb206IFV3
ZSA9P3V0Zi04P1E/S2xlaW5lLUs9QzM9QjZuaWc/PSA8dS5rbGVpbmUta29l
bmlnQHBlbmd1dHJvbml4LmRlPgpUbzogQ2hyaXMgSG95IFBveSB2aWEgUlQg
PGtlcm5lbC1oZWxwZGVza0BydC5saW51eGZvdW5kYXRpb24ub3JnPgpDYzog
dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tClN1YmplY3Q6IFJlOiBbS2VybmVs
Lm9yZyBIZWxwZGVzayAjODk5NDJdIFJlOiBhZGRpbmcgbGludXgtcHdtIGFy
Y2hpdmVzIHRvCiBsb3JlLmtlcm5lbC5vcmc/Ck1lc3NhZ2UtSUQ6IDwyMDIw
MDcyOTA3MjQ1OS5jNmd3a3IyMjRsY2JtZDdyQHBlbmd1dHJvbml4LmRlPgpS
ZWZlcmVuY2VzOiA8UlQtVGlja2V0LTg5OTQyQGxpbnV4Zm91bmRhdGlvbj4K
IDwyMDIwMDIxMzEwMjYxOC54NWo2a2Z2cW1kYngycHIyQHBlbmd1dHJvbml4
LmRlPgogPDIwMjAwNTIzMTcwNTU4LmgyYnJxbGYyang0a2VlNnlAcGVuZ3V0
cm9uaXguZGU+CiA8MDEwMTAxNzM5OGUwNDhjYi00OTc2OTQ0YS1jYzVjLTQx
ODMtYTA3My0xYmYwMTY5MmVjNzctMDAwMDAwQHVzLXdlc3QtMi5hbWF6b25z
ZXMuY29tPgpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IG11bHRp
cGFydC9zaWduZWQ7IG1pY2FsZz1wZ3Atc2hhNTEyOwoJcHJvdG9jb2w9ImFw
cGxpY2F0aW9uL3BncC1zaWduYXR1cmUiOyBib3VuZGFyeT0iZzNmdjZvYncy
ejR4ZmtxZCIKQ29udGVudC1EaXNwb3NpdGlvbjogaW5saW5lCkluLVJlcGx5
LVRvOiA8MDEwMTAxNzM5OGUwNDhjYi00OTc2OTQ0YS1jYzVjLTQxODMtYTA3
My0xYmYwMTY5MmVjNzctMDAwMDAwQHVzLXdlc3QtMi5hbWF6b25zZXMuY29t
PgpYLVNBLUV4aW0tQ29ubmVjdC1JUDogMjAwMTo2N2M6NjcwOjEwMDoxZDo6
YzUKWC1TQS1FeGltLU1haWwtRnJvbTogdWtsQHBlbmd1dHJvbml4LmRlClgt
U0EtRXhpbS1TY2FubmVkOiBObyAob24gbWV0aXMuZXh0LnBlbmd1dHJvbml4
LmRlKTsgU0FFeGltUnVuQ29uZCBleHBhbmRlZCB0byBmYWxzZQpYLVBUWC1P
cmlnaW5hbC1SZWNpcGllbnQ6IGtlcm5lbC1oZWxwZGVza0BydC5saW51eGZv
dW5kYXRpb24ub3JnCgoKLS1nM2Z2Nm9idzJ6NHhma3FkCkNvbnRlbnQtVHlw
ZTogdGV4dC9wbGFpbjsgY2hhcnNldD1pc28tODg1OS0xCkNvbnRlbnQtRGlz
cG9zaXRpb246IGlubGluZQpDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiBx
dW90ZWQtcHJpbnRhYmxlCgpIZWxsbyBDaHJpcywKCk9uIFdlZCwgSnVsIDI5
LCAyMDIwIGF0IDA0OjQxOjQyQU0gKzAwMDAsIENocmlzIEhveSBQb3kgdmlh
IFJUIHdyb3RlOgo+IHRoaXMgaXMgY3VycmVudGx5IGZpbmlzaGluZyB1cCBp
bXBvcnRpbmcgdGhlIGFyY2hpdmUsIGJ1dCBzaG91bGQgYmUgb3RoZXI9Cndp
c2UgYXZhaWxhYmxlIGZvciB1c2UuPTIwCj49MjAKPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1wd20KPj0yMAo+IGFwb2xvZ2llcyBmb3IgYW55
IGRlbGF5cywgcGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGFyZSBhbnkg
aXNzdWVzIQoKR3JlYXQsIHdlIGV2ZW4gZGlkbid0IGhhdmUgdG8gY29sbGVj
dCBmcm9tIG91ciBpbmJveGVzLiBUaGFua3MsIEkgbG9vawpmb3J3YXJkIG9u
IHVzaW5nIHRoaXMgc2VydmljZS4KCkJlc3QgcmVnYXJkcwpVd2UKCi0tPTIw
ClBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8
IFV3ZSBLbGVpbmUtSz1GNm5pZyAgICAgICAgICAgIHwKSW5kdXN0cmlhbCBM
aW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cu
cGVuZ3V0cm9uaXguZGUvIHwKCi0tZzNmdjZvYncyejR4ZmtxZApDb250ZW50
LVR5cGU6IGFwcGxpY2F0aW9uL3BncC1zaWduYXR1cmU7IG5hbWU9InNpZ25h
dHVyZS5hc2MiCgotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQoKaVFF
ekJBQUJDZ0FkRmlFRWZuSXFGcEFZclA4K2RLUUx3ZndVZUszSzdBa0ZBbDho
SkVnQUNna1F3ZndVZUszSwo3QWtEUkFmK0ovdTdQdVJCOXlPN1dtL2c2Nktz
RjZoQ0MxRzJ4ZVhha2dzOGNodjMxZSs1KzhuSmZ0TGYxbDI5CmNTOStob25I
SGNkYWhOc2RFU1FZOVFsdGNuekhjZHU1SGVHOGQ3V1VpYVRaM1NPQ0NLRWNp
amNIam5ScDYzbzIKY3J6M2FZejYwZTlQaTJUNVYrNDIyRXFvQkxkTzlKc2Nx
Z2FDWUpPNHVSMERacWYvUk1NTWsySXRLbzd3cW82QQpINzlWcWI5WTlReXRp
U3VCcXZMOFZUSkRYNnVIemFCckJXLytxeklxdVJqUWNTaFB1dEoxTEgvU1Fu
ZUlqS1IxClNmUVozS0IyRWlSQXVtRXU4b0M2b0FFaXhOZWxmQWlTeW9kRHFH
c0NOaDRwUjQvTWVJUytINjhvSlRYL3ZCeWsKTDNKZFUxb3c2OUlSRFFMQWlX
YW95cmFkUUNWY013PT0KPVk3cnIKLS0tLS1FTkQgUEdQIFNJR05BVFVSRS0t
LS0tCgotLWczZnY2b2J3Mno0eGZrcWQtLQo=

------------=_1596007502-29248-1053--
